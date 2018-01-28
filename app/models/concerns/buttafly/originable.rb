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
      has_many :legends, through: :mappings, as: :originable

      accepts_nested_attributes_for :legends

      aasm do
        state :uploaded, initial: true
        state :mapped
        state :imported
        state :archived

        event :map do
          transitions from: [:uploaded, :mapped, :imported], to: :mapped
        end

        event :import do
          transitions from: :mapped, to: :imported
        end

        event :archive do
          transitions from: [:uploaded, :mapped, :imported], to: :imported
        end
      end

      def originable_headers(file=flat_file)
        data = CSV.read(flat_file.path)
        data.first
      end
    end
  end
end
