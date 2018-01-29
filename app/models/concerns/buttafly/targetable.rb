require 'tsort'

module Buttafly
  class Targetable
    include TSort
    extend ActiveSupport::Concern

    def self.models
      Rails.application.eager_load!
      if blacklisted_models.empty?
        @whitelist = whitelisted_models
        @models = @whitelist.empty? ? targetable_models : @whitelist
      else
        @models = targetable_models - blacklisted_models
      end
      @models - buttafly_blacklist
    end

    def self.blacklisted_models
      return if Buttafly.blacklisted_models.nil?
      Buttafly.blacklisted_models.map {|model| model.to_s }
    end

    def self.whitelisted_models
      return if Buttafly.whitelisted_models.nil?
      Buttafly.whitelisted_models.map {|model| model.downcase.to_sym }
    end

    def self.class_name_of(model, parent)
      parent = (parent.is_a? Symbol) ? parent : parent.name
      klass = klassify(model).reflect_on_association(parent)
      klass_alias = klass.options[:class_name]
      klass_alias.nil? ? klass.name : klass_alias.downcase.to_sym
    end

    def self.parent_ass_with_class_of(model, parent)
      klass = klassify(model).reflect_on_association(klass_to_sym(parent))
      klass_alias = klass.options[:class_name]
      klass_alias.nil? ? { klass.name => nil} : { klass.name => klass_alias.downcase.to_sym }
    end

    def self.targetable_models
      descendants = ActiveRecord::Base.descendants.map(&:name)
      descendants.delete(Buttafly.originable_model)
      descendants.map { |model| model.to_s }
    end

    def self.parents_of(model, parents = [])
      klassify(model).reflect_on_all_associations(:belongs_to).each do |parent|
        parents << parent_ass_with_class_of(model, parent)
      end
      parents
    end

    def self.ancestors_of(model, ancestors=[])
      klassify(model).reflect_on_all_associations(:belongs_to).each do |parent|
        class_name = parent.options.empty? ? parent.name : parent.options[:class_name].downcase.to_sym

        ancestors << { parent.name => { class_name => ancestors_of(class_name)} }
      end
      ancestors
    end

    def self.dancestors_of(model, ancestors=[])
      klassify(model).reflect_on_all_associations(:belongs_to).each do |parent|
        class_name = parent.options.empty? ? parent.name : parent.options[:class_name].downcase.to_sym

        ancestors << { parent.name => { class_name => ancestors_of(class_name)} }
      end
      ancestors
    end

    def targetable_order(parent=nil)
      ancestors = Hash.new
      targetable_parents(parent).each do |p|
        ancestors[p] = targetable_parents(p).empty? ? {} : targetable_order(p)
      end
      ancestors
    end

    def self.targetable_columns(model)
      cols = (model.to_s.classify.constantize.column_names - %w[updated_at created_at id])
      cols.reject! { |col| (col.split('_')).last.match? "id" }
      cols
    end

  private

    def self.modelize(string)
      string.to_s.classify.constantize
    end

    def self.klass_to_sym(klass)
      (klass.is_a? Symbol) ? klass : klass.name
    end

    def self.klassify(model)
      model.to_s.classify.constantize
    end

    def self.buttafly_blacklist

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
