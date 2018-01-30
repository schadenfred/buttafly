require 'date'
require 'byebug'
class Buttafly::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)


  def copy_buttafly_initializer_to_host
    copy_file "buttafly_initializer.rb", "config/initializers/buttafly.rb"
    return if originable_model.nil?
    file = dummy("config/initializers/buttafly.rb")
    code = originable_model.to_s.classify
    gsub_file file, "Buttafly::Spreadsheet", code
  end

  def copy_routes_to_host
    directory "routes", dummy("config/routes")
  end

  def add_routes_to_autoload_path
    file = dummy("config/application.rb")
    code = %q[config.autoload_paths += %W(#{config.root}/config/routes)]
    after = "class Application < Rails::Application"
    pretty_file_insert(file, code, after)
  end

  def mount_engine_to_app
    file = dummy("config/routes.rb")
    code = "extend EngineRoutes"
    after = "Rails.application.routes.draw do"
    pretty_file_insert(file, code, after)
  end

  def include_originable_module_in_originable_model
    return if originable_model.nil?
    file = "app/models/#{originable_model.to_s.singularize.underscore}.rb"
    code = %q[include Buttafly::Originable]
    after = "ApplicationRecord"
    pretty_file_insert(file, code, after)
  end

  def copy_migrations
    migrations = Dir[Buttafly::Engine.root.join("db/migrate/*.rb")]
    migrations.each do |m|
      timestamp = (DateTime.now.strftime "%Y%m%d%H%M%S")
      name = m.split("_").last
      copy_file m, "db/migrate/#{timestamp}_buttafly_#{name}"
    end
  end

private

  def originable_model
    args.empty? ? nil : args.first
  end

  def dummy(filename)
    Rails.root.join(filename)
  end

  def newline(line)
    "\n\t\t" + line + "\n"
  end

  def matcher(line)
    line + "\n"
  end

  def pretty_file_insert(file, code, after)

    insert_into_file dummy(file), newline(code), after: after
  end
end
