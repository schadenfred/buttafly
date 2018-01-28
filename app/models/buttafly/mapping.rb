module Buttafly
  class Mapping < ApplicationRecord

    belongs_to :legend
    belongs_to :originable, polymorphic: true

    accepts_nested_attributes_for :legend
  end
end
