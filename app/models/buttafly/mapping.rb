module Buttafly
  class Mapping < ApplicationRecord

    belongs_to :legend
    belongs_to :originable, polymorphic: true
  end
end
