module Buttafly
  class Legend < ApplicationRecord

    has_many :mappings
    has_many :originables, through:     :mappings,
                           source:      :originable,
                           source_type: Buttafly.originable_model

    serialize :data
    serialize :originable_headers


  end
end
