module Buttafly
  class Originable < ActiveRecord::Base

    has_many :mappings
  end
end
