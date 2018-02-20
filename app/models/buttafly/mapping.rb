class Buttafly::Mapping < ApplicationRecord

  require "tsortable"
  require "csv"
  require "json"
  require "roo"

  include AASM
  include Buttafly

  belongs_to :legend, class_name: "Buttafly::Legend"
  belongs_to :originable, polymorphic: true

  has_many :artifacts

  accepts_nested_attributes_for :legend

  aasm do
    state :importable
    state :imported

    event :import do
      transitions from: :importable, to: :imported, after: :transmogrify
    end

    event :revert do
      transitions from: [:imported], to: :impoortable
    end
  end

  def headers
    self.originable.originable_headers
  end

  def data
    legend.data
  end

  def targetable_models
    Targetable.models
  end

  def ancestors
    Targetable.ancestors_of(legend.targetable_model)
  end

  def get_parent(key, klass)
    if klass.nil?
      parent = key
    else
      parent = klassify(klass).reflect_on_association(key).class_name.downcase
    end
    parent
  end

  def create_records(row, klass = nil, hash=data)
    attrs = {}
    hash.each do |key, value|
      if value.is_a? Hash
        create_records(row, get_parent(key, klass), value)
      else
        attrs[key] = row[value]
      end
      unless klass.nil?
        parents = klassify(klass).reflect_on_all_associations(:belongs_to)
        parents.each do |parent|
          pc = klassify(parent.class_name)
          items = pc.where(hash[parent.class_name.to_s])
          unless items.empty?
            items.each do |item|
              parent_id = item.id
              attrs["#{parent.name.to_s}_id"] = parent_id
            end
          end
        end
        create_artifact(klass, attrs)
        klassify(klass).create(attrs)
      end
    end
  end

  def findable_attrs(model)
    attrs = []
    klass = model.to_s.classify.constantize
    klass.validators.select do |validator|
      validator.attributes.each do |attr|
        if (klass.column_names.include? attr.to_s) && (!attr.match? /_id/)
          attrs << attr
        end
      end
    end
    attrs.uniq
  end

  def create_artifact(model, attrs)
    klass = klassify(model)
    # byebug
    # if klass.find(attrs)
    artifacts.create(is_new: true, data: { model => attrs} )
    klassify(model).where(attrs).first_or_create
  end

  def transmogrify
    csv = CSV.open(originable.flat_file.path, headers:true).readlines
    csv.each { |row| create_records(row) }
  end

private

  def klassify(model)
    model.classify.constantize
  end
end
