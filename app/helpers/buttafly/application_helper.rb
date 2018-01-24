module Buttafly
  module ApplicationHelper

    def main_app_name
      Rails.application.class.parent.name
    end
  end
end
