require 'test_helper'
require 'generators/buttafly/install/install_generator'

module Buttafly
  describe Buttafly::InstallGenerator do
    tests Buttafly::InstallGenerator
    include FileManipulationHelpers
    destination Rails.root.join('tmp/generators')

    setup :prepare_destination

    setup do
      system "git checkout test/dummy/"
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
      system "git checkout test/dummy/"
    end

    specify { assert_nothing_raised { run_generator } }
    specify { assert_nothing_raised { run_generator ["excel_sheet"] } }

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

    describe "with originable_model argument" do

      specify "includes Buttafly::Originable in originable_model" do
        file = "app/models/excel_sheet.rb"
        line = %q[include Buttafly::Originable]
        remove_line(file, line)
        run_generator ["excel_sheet"]
        assert_file dummy(file), /include Buttafly::Originable/
      end
    end
  end
end
