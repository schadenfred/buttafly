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
      # File.exists?("test/dummy/config/initializers/buttafly.rb") do
        system "rm test/dummy/config/initializers/buttafly.rb"
      # end
      # File.exists?("test/dummy/config/routes/engine_routes.rb") do
        system "rm -rf test/dummy/config/routes"
        system "rm -rf test/dummy/config/routes/"
      # end
      system "rm test/dummy/config/initializers/buttafly.rb"
      system "cp Gemfile test/dummy/Gemfile"

      filename = Rails.root.join "config/routes.rb"
      mounter = "mount Buttafly::Engine => \"/buttafly\""
      gsub_file(filename, mounter, '')

    end

    teardown do
      system "git checkout test/dummy/config/application.rb"
      system "git checkout test/dummy/config/routes.rb"
      system "git checkout test/dummy/config/initializers/buttafly.rb"
      system "rm test/dummy/Gemfile"
    end

    specify "creates initializer in host app" do
      run_generator
      assert_file "config/initializers/buttafly.rb"
      assert_file "config/routes/"
      assert_file "config/routes/engine_routes.rb"
      assert_file Rails.root.join("config/routes.rb"), /extend EngineRoutes/
      assert_file Rails.root.join("Gemfile"), /buttafly/
      assert_file Rails.root.join("config/application.rb"), /config\/routes/
    end

    # specify "creates config/routes/ directory" do
    # end
    #
    # specify "creates config/routes/engine_routes.rb" do
    # end

    # specify "adds EngineRoutes to " do
    # end

    # specify "adds gem to Gemfile" do
    # end

    # specify "adds engine_routes file to autoload path" do
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
  #   # system "rm test/dummy/Gemfile"
  # end
  #
#
#   end
# end
