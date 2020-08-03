module Buttafly
  class Mapping < ApplicationRecord

    require "tsortable"
    require "csv"
    require "json"
    require "roo"

    include AASM
    include Buttafly

    belongs_to :legend, class_name: "Buttafly::Legend"
    belongs_to :originable, polymorphic: true

    has_many :artifacts, foreign_key: :mapping_id, class_name: "Buttafly::Artifact"

    accepts_nested_attributes_for :legend
    accepts_nested_attributes_for :artifacts

    aasm do
      state :importable
      state :imported

      event :import do
        transitions from: :importable, to: :imported,
                                       after: :transmogrify
      end

      event :revert do
        transitions from: :imported, to: :importable,
                                       after: :revert_all_records
      end
    end

    def headers
      self.originable.originable_headers
    end

    def data
      legend.data
    end

    def targetable_models
      Buttafly::Targetable.models
    end

    def ancestors
      Targetable.ancestors_of(legend.targetable_model)
    end

    def get_parent(key, klass=nil)
      if klass.nil?
        parent = key
      else
        parent = klassify(klass).reflect_on_association(key).class_name.downcase
      end
      parent
    end

    def create_records(row, hash=data)
      attrs = {}
      hash.each do |key, value|
        value.keys.each do |attribute|
          if value[attribute].is_a? Hash
            create_records(row, { attribute.capitalize => value[attribute]})
          else
            attrs[attribute] = row[value[attribute]]
          end
        end

        parents = key.constantize.reflect_on_all_associations(:belongs_to)
        unless parents.empty?
          parents.each do |parent|
            parent_name = parent.class_name
            parent_class = parent.class_name.constantize
            bt = parent_class.where(row[value[parent_name.downcase]]).first
            attrs[parent_name.downcase + '_id'] = bt.id
          end
        end
        key.constantize.create!(attrs)

      end
    end

    def findable_attrs(model, all_attrs)
      attrs = []
      klass = model.to_s.classify.constantize
      klass.validators.select do |validator|
        if validator.is_a? ActiveRecord::Validations::UniquenessValidator
          validator.attributes.each do |attr|
            parents = klass.reflect_on_all_associations(:belongs_to).map(&:name)
            attrs << ((parents.include?(attr)) ? (attr.to_s + "_id") : attr.to_s)
          end
        end
      end
      (all_attrs.slice *attrs)
    end

    def create_artifact(model, attrs)
      attrs.stringify_keys!
      klass = klassify(model)
      case
      when record = klass.find_by(attrs)
        artifacts.create(status: "was_duplicate", data: {
                         "artifactable_id" => record.id, model => attrs} )
      when record = klass.find_by(findable_attrs(model, attrs))
        artifacts.create(status: "was_updated", data: {
                         "artifactable_id" => record.id, model => record.attributes} )
        record.update(attrs)
      when record = klass.create(attrs)
        arty = Buttafly::Artifact.create(mapping_id: self.id, status: "was_new", data: {
                         "artifactable_id" => record.id, model => attrs} )
      end
    end

    def transmogrify
      csv = CSV.open(originable.flat_file.path, headers:true).readlines
      csv.each { |row| create_records(row) }
    end

    def revert_all_records
      artifacts.each do |artifact|
        artifact.revert_record
      end
    end

  private

    def klassify(model)
      model.classify.constantize
    end
  end
end
