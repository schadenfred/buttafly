require 'test_helper'
require 'generators/buttafly/install/install_generator'

module Buttafly
  describe Buttafly::InstallGenerator do
    tests Buttafly::InstallGenerator
    include FileManipulationHelpers
    destination Rails.root.join('tmp/generators')

    # specify { assert_nothing_raised { run_generator } }

    setup do
      :prepare_destination
      File.exists?("test/dummy/config/initializers/buttafly.rb") do
        FileUtils.rm "test/dummy/config/initializers/buttafly.rb"
      end
      File.exists?("test/dummy/config/routes/engine_routes.rb") do
        FileUtils.rm "test/dummy/config/routes/engine_routes.rb"
      end
      File.exists?("test/dummy/config/routes") do
        FileUtils.rmdir "test/dummy/config/routes"
      end
    end

    teardown do
      system "git checkout test/dummy/config/application.rb"
      system "git checkout test/dummy/config/routes.rb"
      system "git checkout test/dummy/config/routes/engine_routes.rb"
      system "git checkout test/dummy/config/initializers/buttafly.rb"
      # system "git checkout test/dummy/app/models/excel_sheet.rb"
    end

    describe "generator without argument" do

      specify "creates initializer in host app" do
        run_generator
        assert_file "config/initializers/buttafly.rb"
      end

      specify "creates config/routes directory" do
        run_generator
        assert_file Rails.root.join("config/routes")
      end

      specify "creates config/routes/engine_routes.rb" do
        run_generator
        assert_file Rails.root.join("config/routes/engine_routes.rb")
      end

      specify "adds engine_routes file to autoload path" do
        filename = Rails.root.join "config/application.rb"
        line = %q[config.autoload_paths += %W(#{config.root}/config/routes)]
        gsub_file(filename, line, '')
        run_generator
        assert_file Rails.root.join("config/application.rb"), /config\/routes/
      end

      specify "adds EngineRoutes to " do
        filename = Rails.root.join "config/application.rb"
        line = %q[extend EngineRoutes]
        gsub_file(filename, line, '')
        run_generator
        assert_file Rails.root.join("config/routes.rb"), /extend EngineRoutes/
      end
    end

    describe "generator with originable_model argument" do

      # specify "creates initializer in host app" do
      #   run_generator ["excel_sheet"]
      #   assert_file "config/initializers/buttafly.rb"
      #   assert_file Rails.root.join("app/models/excel_sheet.rb"), /include/
      # end

    #   specify "creates config/routes directory" do
    #     run_generator
    #     assert_file Rails.root.join("config/routes")
    #   end
    #
    #   specify "creates config/routes/engine_routes.rb" do
    #     run_generator
    #     assert_file Rails.root.join("config/routes/engine_routes.rb")
    #   end
    #
    #   specify "adds engine_routes file to autoload path" do
    #     filename = Rails.root.join "config/application.rb"
    #     line = %q[config.autoload_paths += %W(#{config.root}/config/routes)]
    #     gsub_file(filename, line, '')
    #     run_generator
    #     assert_file Rails.root.join("config/application.rb"), /config\/routes/
    #   end
    #
    #   specify "adds EngineRoutes to " do
    #     filename = Rails.root.join "config/application.rb"
    #     line = %q[extend EngineRoutes]
    #     gsub_file(filename, line, '')
    #     run_generator
    #     assert_file Rails.root.join("config/routes.rb"), /extend EngineRoutes/
    #   end
    end
  end
end
