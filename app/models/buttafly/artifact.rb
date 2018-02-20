module Buttafly
  class Artifact < ApplicationRecord
    belongs_to :mapping

    enum status: [ :was_new, :was_updated, :was_duplicate ]
    serialize :data

    def revert_record
      record_klass = data.keys.second.classify.constantize
      record_id = data["artifactable_id"]
      record = record_klass.find(record_id)
      artifact_attrs = data.values.second
      record_attrs = record.attributes.except("created_at", "updated_at", "id")
      if (record_attrs.merge artifact_attrs) == artifact_attrs
        record.delete
      end
      self.delete
    end
  end
end
