module Originable

  extend ActiveSupport::Concern

  module ClassMethods

    def originable?
      true
    end
  end

  included do

    has_many :mappings
    has_many :legends, through: :mappings
  end
end
