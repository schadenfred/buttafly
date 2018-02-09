module Buttafly
  class Mapping < ApplicationRecord

    belongs_to :legend, class_name: "Buttafly::Legend"
    belongs_to :originable, polymorphic: true

    accepts_nested_attributes_for :legend

    def headers
      self.originable.originable_headers
    end

    def data
      legend.data
    end

    def create_records!

    end

    def transmogrify!

    end
  end
end
