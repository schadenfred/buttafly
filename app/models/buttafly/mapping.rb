module Buttafly
  class Mapping < ApplicationRecord

    belongs_to :legend, class_name: "Buttafly::Legend"
    belongs_to :originable, polymorphic: true

    accepts_nested_attributes_for :legend



    def transmogrify!
      # byebug

    end
  end
end
