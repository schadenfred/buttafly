class Buttafly::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_buttafly_initializer_file
    originable_model = args.first

    copy_file "buttafly_initializer.rb", "config/initializers/buttafly.rb"
    unless originable_model.nil?
      initializer = "config/initializers/buttafly.rb"
      gsub_file initializer, "Spreadsheet", originable_model.capitalize
    end
  end

  def mount_engine_to_app

    filename = Rails.root.join("config/routes.rb")
    unless File.read(filename).match "Buttafly"

      mounter = "\tmount Buttafly::Engine => \"/buttafly\"\n"
      previous = "Rails.application.routes.draw do\n"

      insert_into_file filename, mounter, after: previous
    end

  end
end
