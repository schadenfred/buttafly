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
        system "rm test/dummy/config/initializers/buttafly.rb"
      end
      system "cp Gemfile test/dummy/Gemfile"

      filename = Rails.root.join "config/routes.rb"
      mounter = "mount Buttafly::Engine => \"/buttafly\""
      gsub_file(filename, mounter, '')

      run_generator
    end

    teardown do
      system "git checkout test/dummy/config/application.rb"
      system "git checkout test/dummy/config/routes.rb"
      system "git checkout test/dummy/config/initializers/buttafly.rb"
      system "rm test/dummy/Gemfile"
    end

    specify "creates initializer in host app" do
      assert_file "config/initializers/buttafly.rb"
    end

    specify "creates config/routes/ directory" do
      assert_file "config/routes/"
    end

    specify "creates config/routes/engine_routes.rb" do
      assert_file "config/routes/engine_routes.rb"
    end

    specify "adds EngineRoutes to " do
      assert_file Rails.root.join("config/routes.rb"), /extend EngineRoutes/
    end

    specify "adds gem to Gemfile" do
      assert_file Rails.root.join("Gemfile"), /buttafly/
    end

    specify "adds engine_routes file to autoload path" do
      assert_file Rails.root.join("config/application.rb"), /config\/routes/
    end
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
  #   # system "rm test/dummy/Gemfile"
  # end
  #
#
#   end
# end
