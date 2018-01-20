require 'test_helper'
require 'generators/buttafly/install/install_generator'

describe Buttafly::InstallGenerator do
  tests Buttafly::InstallGenerator

  include FileManipulationHelpers

  destination Rails.root.join('tmp/generators')

  setup :prepare_destination

  teardown do
    system "git checkout test/dummy/config"
  end

  describe "sanity" do

    specify { assert_nothing_raised { run_generator } }
    specify { assert_nothing_raised { run_generator ["excel_sheet"] } }
  end

  describe "before running generator" do

    Given { reset_dummy_app }
    Then { verify_dummy_app_initial_state }
  end

  describe "without arguments" do

    Given { run_generator }

    describe "must create buttafly.rb initializer in host app" do

      Then { assert_file "config/initializers/buttafly.rb" }
    end

    describe "must create engine_routes.rb in config/routes/" do

      Then { assert_file Rails.root.join("config/routes") }
      And { assert_file Rails.root.join("config/routes/engine_routes.rb") }
    end

    describe "must add routes/ folder to autoload path" do

      Given(:file) { "config/application.rb" }
      Given(:line)  { %q[config.autoload_paths += %W(#{config.root}/config/routes)] }

      Then { File.read(dummy(file)).must_match line }
    end

    describe "must mount engine routes to app" do

      Given(:file) { "config/routes.rb" }

      Then { File.read(dummy(file)).must_match "extend EngineRoutes" }
    end
  end

  describe "with originable_model argument" do

    arguments = ["excel_sheet", :excel_sheet, "ExcelSheet", "excel_sheets", "ExcelSheets"]
    arguments.each do |argument|

      Given { run_generator [argument] }

      describe "must include Buttafly::Originable in chosen model" do

        Given(:file) { "app/models/excel_sheet.rb" }
        Given(:line)  { %q[include Buttafly::Originable] }

        Then { File.read(dummy(file)).must_match line }
      end

      describe "must add config.originable_model to buttafly.rb" do

        Given(:file) { "config/initializers/buttafly.rb" }
        Given(:line)  { %q[config.originable_model = "ExcelSheet"] }

        Then { File.read(dummy(file)).must_match line }
      end
    end
  end
end
