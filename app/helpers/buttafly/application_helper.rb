module Buttafly
  module ApplicationHelper

    def main_app_name
      Rails.application.class.parent.name
    end

    def ancestors
      Buttafly::Targetable.ancestors_of(@targetable_model)
    end

    def mapping_selectors(model)
      Buttafly::Targetable.targetable_columns(model)
    end

    def locals(ancestor, f, i)
      locals = { f: f, i: i}
      locals[:ancestors] = ancestor.values.first.values.first
      locals[:a] = ancestor.keys.first
      locals[:m] = ancestor.values.first.first.first
      locals
    end
  end
end
