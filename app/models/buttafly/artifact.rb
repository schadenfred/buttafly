module Buttafly
  class Artifact < ApplicationRecord
    belongs_to :mapping

    serialize :data

  end
end
