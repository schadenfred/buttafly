require 'test_helper'
require 'generators/buttafly/install/install_generator'

module Buttafly
  describe Buttafly::InstallGenerator do
    tests Buttafly::InstallGenerator
    include FileManipulationHelpers
    destination Rails.root.join('tmp/generators')

    specify { assert_nothing_raised { run_generator } }

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
      # system "git checkout test/dummy/config/routes/engine_routes.rb"
      # system "git checkout test/dummy/config/initializers/buttafly.rb"
    end

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

    specify "adds EngineRoutes to " do
      run_generator
      assert_file Rails.root.join("config/routes.rb"), /extend EngineRoutes/
    end

    specify "adds engine_routes file to autoload path" do
      filename = Rails.root.join "config/application.rb"
      line = %q[config.autoload_paths += %W(#{config.root}/config/routes)]
      gsub_file(filename, line, '')
      run_generator
      assert_file Rails.root.join("config/application.rb"), /config\/routes/
    end
    # specify "creates config/routes/engine_routes.rb" do
    # end


  end
end

    # describe "with originable model specified as first arg" do
    #
    #   describe "configures with default spreadsheet" do
    #
    #     Given { run_generator ["dick"]}
    #     Then { assert_file "config/initializers/buttafly.rb", /Dick/ }
    #   end
    # end

    # Given(:filename) { Rails.root.join "config/routes.rb" }
    # Given(:mounter) { "mount Buttafly::Engine => \"/buttafly\"" }
    # Given { gsub_file(filename, mounter, '') }

  #   autoload_config = %q[config.autoload_paths += %W(#{config.root}/config/routes)]
    # assert_file Rails.root.join("config/application.rb")
  # end
  #
#
#   end
# end
