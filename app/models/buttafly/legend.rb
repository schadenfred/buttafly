module Buttafly
  class Legend < ApplicationRecord

    has_many :mappings,     dependent:    :destroy
    has_many :originables,  through:      :mappings,
                            source:       :originable,
                            source_type:  Buttafly.originable_model

    serialize :data
    serialize :originable_headers

    def default_name
      name.blank? ? targetable_model : name
    end
  end
end
