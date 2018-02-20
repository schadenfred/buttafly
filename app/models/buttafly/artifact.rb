module Buttafly
  class Artifact < ApplicationRecord
    belongs_to :mapping

    enum status: [ :was_new, :was_updated, :was_duplicate ]
    serialize :data
  end
end
