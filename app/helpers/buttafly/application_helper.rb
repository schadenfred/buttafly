module Buttafly
  module ApplicationHelper
    def flash_class(level)
      case level
      when :notice
        "alert-info"
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-error"
      end
    end

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

    def event_buttons_for(model_with_aasm)
      buttons = []
      if model_with_aasm.respond_to? :aasm
        model_with_aasm.aasm.events.map(&:name).each do |a|
          action = a.to_s
          singularized_model = model_with_aasm.class.to_s.split(":").last.to_s.downcase
          path = eval("#{action}_#{singularized_model}_url(model_with_aasm)")
          id = "#{action}Mapping-#{model_with_aasm.id}"
          buttons << (button_to(path, method: :patch, class: btn_class(action), id: id) {action})
        end
      end
      buttons << (button_to(model_with_aasm, class: btn_class("destroy"), id: "destroy#{model_with_aasm.class}-#{model_with_aasm.id}") { "destroy" } )
    end

    def btn_class(action)
      hash = {
        "import" => "success",
        "revert" => "warning",
        "destroy" => "danger"
      }
      "btn-group btn btn-#{hash[action]}"
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
