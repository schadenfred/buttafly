module Buttafly
  class Mapping < ApplicationRecord

    require "tsortable"

    belongs_to :legend, class_name: "Buttafly::Legend"
    belongs_to :originable, polymorphic: true

    accepts_nested_attributes_for :legend

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

    def create_records(row, klass=nil, hash=nil)
      hash ||= data
      klass ||= data.first.first
      attrs = {}
      hash.each do |key, value|
        if value.is_a? Hash
          if key == klass
            parent = key
          else
            parent = klass.classify.constantize.reflect_on_association(key).class_name.downcase
          end
          create_records(row, parent, value)
        else
          attrs[key] = row[value]
        end
      end
      parents = klass.classify.constantize.reflect_on_all_associations(:belongs_to)
      parents.each do |parent|
        parent_id = parent.class_name.constantize.where(hash[parent.class_name.to_s]).first.id
        attrs["#{parent.name}_id"] = parent_id
      end
      record = klass.classify.constantize.first_or_create(attrs)
    end

    def transmogrify
      csv = CSV.open(originable.flat_file.path, headers:true).readlines
      # csv.each do |row|
        create_records(csv.first)
      # end
    end
  end
end
