module Buttafly
  module Originable

    extend ActiveSupport::Concern

    module ClassMethods

      def originable?
        true
      end
    end

    included do

      require "csv"
      require "json"
      require "roo"

      include AASM

      serialize :avatars, JSON

      has_many :mappings, as: :originable
      has_many :legends, through: :mappings

      def originable_headers(file=flat_file)

        data = CSV.read(flat_file.path)
        data.first
      end
    end
  end
end
