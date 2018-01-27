module Buttafly
  class Engine < ::Rails::Engine
    isolate_namespace Buttafly

    config.generators do |g|
      g.template_engine :haml
    end
  end
end
