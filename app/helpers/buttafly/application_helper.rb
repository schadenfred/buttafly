module Buttafly
  module ApplicationHelper

    def main_app_name
      Rails.application.class.parent.name
    end

    def ancestors
      Buttafly::Targetable.ancestors_of(@targetable_model)
    end

    def children(parent, col, children=nil)
      children ||= {}
      @legend.data
      children[parent] = col
    end

    def mapping_selectors(model)
      Buttafly::Targetable.targetable_columns(model)
    end

    def legend_node(legend)
      legend_node = legend.data

    end

    def header_at(legend, lineage, column)
      "[\"#{lineage.join("\"][\"")}\"][\"#{column}\"]"
    end

    def locals(ancestor, f, i, parent=nil)
      lineage ||= []
      if parent.nil?
        lineage_parent = lineage
      else
        lineage_parent = lineage + parent
      end
      ancestors = ancestor.values.first.values.first
      lineage_parent << ancestor.keys.first.to_s
      locals = {
        f: f,
        i: i,
        lineage: lineage_parent,
        ancestors: ancestors,
        a: ancestor.keys.first,
        m: ancestor.values.first.first.first
      }
      locals
    end
  end
end
