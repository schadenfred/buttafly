class Buttafly::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_buttafly_initializer_to_host
    originable_model = args.first
    copy_file "buttafly_initializer.rb", "config/initializers/buttafly.rb"
    unless originable_model.nil?
      initializer = "config/initializers/buttafly.rb"
      gsub_file initializer, "Spreadsheet", originable_model.capitalize
    end
  end

  def create_engine_routes_file
    directory "routes", Rails.root.join("config/routes")
  end

  def add_engine_routes_to_autoload_path
    filename = Rails.root.join("config/application.rb")
    # unless File.read(filename).match "/config/routes"
      config_line = %q[config.autoload_paths += %W(#{config.root}/config/routes)]
      addition = "\t\t" + config_line + "\n"
      previous = "class Application < Rails::Application\n"

      insert_into_file filename, addition, after: previous
    # end
  end
  #   copy_file "buttafly_routes.rb", "config/routes/engine_routes.rb"

  def mount_engine_to_app
    filename = Rails.root.join("config/routes.rb")
    unless File.read(filename).match "EngineRoutes"
      mounter = "\textend EngineRoutes\n"
      previous = "Rails.application.routes.draw do\n"
      insert_into_file filename, mounter, after: previous
    end
  end

  # def add_engine_routes_to_autoload_path
  #   unless originable_model.nil?
  #     initializer = "config/initializers/buttafly.rb"
  #     gsub_file initializer, "Spreadsheet", originable_model.capitalize
  #   end
  # end

end
