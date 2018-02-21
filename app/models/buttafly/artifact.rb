module Buttafly
  class Artifact < ApplicationRecord
    include Buttafly

    belongs_to :mapping, class_name: "Buttafly::Mapping"

    enum status: [ :was_new, :was_updated, :was_duplicate ]
    serialize :data

    def revert_record
      case status
      when "was_new"
        record_klass = data.keys.second.classify.constantize
        record_id = data["artifactable_id"]
        record = record_klass.find(record_id)
        artifact_attrs = data.values.second
        record_attrs = record.attributes.except("created_at", "updated_at", "id")
        if (record_attrs.merge artifact_attrs) == artifact_attrs
          record.delete
        end

      when "was_updated"
        record_klass = data.keys.second.classify.constantize
        record_id = data["artifactable_id"]
        record = record_klass.find(record_id)
        artifact_attrs = data.values.second
        record_attrs = record.attributes
        artifact_attrs.each do |key, value|
          record_attrs[key] = value
        end
        record.update(record_attrs)
      end
      self.delete
    end
  end
end
