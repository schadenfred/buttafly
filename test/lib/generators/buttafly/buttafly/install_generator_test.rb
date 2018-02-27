require "test_helper"
require 'generators/buttafly/install/install_generator'

describe Buttafly::InstallGenerator do

  tests Buttafly::InstallGenerator

  destination File.expand_path(Rails.root.join("tmp"), File.dirname(__FILE__))

  setup :prepare_destination

  describe "sanity" do

    specify { assert_nothing_raised { run_generator ["excel_sheet"] } }
    specify { assert_nothing_raised { run_generator } }
  end

  describe "generate buttafly:install" do

    describe "without arguments" do

      Given { run_generator }

      describe "must create buttafly.rb initializer in host app" do

        Then { assert_file "config/initializers/buttafly.rb" }
      end

      describe "must add routes/ folder to autoload path" do

        Then { assert_directory "config/routes" }
      end

      describe "must create engine_routes.rb in config/routes/" do

        Then { assert_file "config/routes/engine_routes.rb" }
      end

      describe "must copy migrations" do

        Then { assert_no_migration "db/migrate/create_buttafly_tables.rb"}
      end

      describe "must add EngineRoutes to config/routes.rb" do

        Then { assert_file Rails.root.join("config/routes.rb"), /extend EngineRoutes/ }
      end

      describe "must add routes autoload_path to application.rb" do

        Given(:line)  { %q[config.autoload_paths += %W(#{config.root}/config/routes)] }

        Then { assert_no_file "config/application.rb" }
      end
    end

    describe "with model argument" do

      Given { run_generator ["excel_sheet"] }

      describe "must create buttafly.rb initializer in host app" do

        Then { assert_file "config/initializers/buttafly.rb", /ExcelSheet/ }
      end

      describe "must add routes/ folder to autoload path" do

        Then { assert_directory "config/routes" }
      end

      describe "must create engine_routes.rb in config/routes/" do

        Then { assert_file "config/routes/engine_routes.rb" }
      end

      describe "must create engine_routes.rb in config/routes/" do

        Given(:line)  { %q[config.autoload_paths += %W(#{config.root}/config/routes)] }

        Then { assert_no_file "config/application.rb" }
      end

      describe "must add buttafly::Originable to excel_sheet.rb" do

        # Then { assert_file "app/models/excel_sheet.rb", /Buttafly::Originable/ }
      end
    end
  end
end
#
#       Then { File.read(dummy(file)).must_match line }
#     end
#
#     describe "must mount engine routes to app" do
#
#       Given(:file) { "config/routes.rb" }
#
#       Then { File.read(dummy(file)).must_match "extend EngineRoutes" }
#     end
#
#     describe "remove_files_for_testing(pattern, directory)" do
#       Given { File.open(dummy("db/migrate/test_file_with_buttafly_in_name.rb", "w"))}
#       Given { remove_files_for_testing("db/migrate/", "buttafly")}
#     end
#
#
#     describe "must copy migration files" do
#
#       # Then { assert_migration "/db/migrate/create_buttafly_legends.rb" }
#
#     end
#   end
#
#   describe "with originable_model argument" do
#     Given { skip }
#
#     arguments = ["excel_sheet", :excel_sheet, "ExcelSheet", "excel_sheets", "ExcelSheets"]
#     arguments.each do |argument|
#
#       Given { run_generator [argument] }
#
#       describe "must include Buttafly::Originable in chosen model" do
#
#         Given(:file) { "app/models/excel_sheet.rb" }
#         Given(:line)  { %q[include Buttafly::Originable] }
#
#         Then { File.read(dummy(file)).must_match line }
#       end
#
#       describe "must add config.originable_model to buttafly.rb" do
#
#         Given(:file) { "config/initializers/buttafly.rb" }
#         Given(:line)  { %q[config.originable_model = "ExcelSheet"] }
#
#         Then { File.read(dummy(file)).must_match line }
#       end
#     end
#   end
# end
