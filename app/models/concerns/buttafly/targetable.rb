require 'tsort'

module Buttafly
  class Targetable
    include TSort
    extend ActiveSupport::Concern

    def self.models
      Rails.application.eager_load!
      @whitelist = Buttafly.whitelisted_models
      @models = @whitelist.empty? ? targetable_models : @whitelist
    end

    def self.targetable_models
      descendants = ActiveRecord::Base.descendants.map(&:name)
      descendants - blacklist
    end

    def self.parents_of(model, parents = [])
      klassify(model).reflect_on_all_associations(:belongs_to).each do |parent|
        parents << parent.name
      end
      parents
    end

    def self.class_name_of(parent)
      # klassify(parent).reflect_on_all_associations(:belongs_to).each do |parent|
    end

    def self.ancestors_of(model, ancestors=[])
      parents_of(model).each do |parent|
        if parents_of(parent).empty?
          ancestors << parent
        end
        #   hash[parent] = ancestors_of(parent, hash)
        # end
      end
      # ancestors[parents_of(model)] = ancestors_of(k,v)
      # ancestors.each do |k,v|
      #   if v.is_a? Hash
      #   end
      # end
      # if parent.options[:class_name].nil?
      #   parents << parent.name
      # else
      #   parents << parent.options[:class_name].constantize.model_name.i18n_key
      # end
      ancestors
    end

    def targetable_order(parent=nil)
      ancestors = Hash.new
      targetable_parents(parent).each do |p|
        ancestors[p] = targetable_parents(p).empty? ? {} : targetable_order(p)
      end
      ancestors
    end


  private

    def self.modelize(string)
      string.to_s.classify.constantize
    end

    def self.klassify(string)
      string.to_s.classify.constantize
    end

    def self.blacklist
      @blacklist = ["ActiveRecord::SchemaMigration", "ApplicationRecord", "Buttafly::ApplicationRecord", "Buttafly::Mapping",
        "Buttafly::Spreadsheet", "Buttafly::Legend"]
    end
  end
end
#     module ClassMethods
#       def funston
#
#
#       end
#
#       # def targetable?
#       #   true
#       # end
#     end
#
#     module TargetableModels
#
#       extend self
#
#       @included_in ||= []
#
#       def add(klass)
#         @included_in << klass
#       end
#
#       def included_in
#         @included_in
#       end
#     end
#
#     included do
#
#       TargetableModels.add self
#
#       def self.targetable_ignored_columns
#         ["updated_at", "created_at", "id"]
#       end
#
#       def self.targetable_columns
#         column_names - targetable_ignored_columns
#       end
#
#       def self.targetable_foreign_keys
#         parents = self.reflect_on_all_associations(:belongs_to).map(&:name)
#       end
#
#       def self.targetable_attrs
#         attrs = targetable_columns
#         parents = self.reflect_on_all_associations(:belongs_to).map(&:name)
#         parents.each do |p|
#           fk = p.to_s.capitalize.foreign_key
#           attrs.delete(fk)
#         end
#         attrs
#       end
#     end
#   end
# end
