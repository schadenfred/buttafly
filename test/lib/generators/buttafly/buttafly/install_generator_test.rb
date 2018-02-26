require "test_helper"
require 'generators/buttafly/install/install_generator'

describe Buttafly::InstallGenerator do

  tests Buttafly::InstallGenerator

  destination File.expand_path(Rails.root.join("tmp"), File.dirname(__FILE__))

  setup :prepare_destination

#   # def cleanup
#   #   system "git checkout test/dummy/config"
#   #   system "git checkout test/dummy/app/models/excel_sheet.rb"
#   # end
#   #
#   #
#   # setup do
#   #   remove_files_for_testing("buttafly", "db/migrate/")
#   #   remove_file_for_testing(dummy("config/initializers/buttafly.rb"))
#   #   cleanup
#   # end
#   # teardown { cleanup }
#   #
  describe "sanity" do

    specify { assert_nothing_raised { run_generator ["excel_sheet"] } }
    specify { assert_nothing_raised { run_generator } }
  end
#
#   # describe "before running generator" do
#   #
#   #   Given { reset_dummy_app }
#   #   Then { verify_dummy_app_initial_state }
#   # end
#
  describe "generate buttafly:install" do

    describe "without arguments" do
      Given { run_generator }

      describe "must create buttafly.rb initializer in host app" do
        # Then { Rails.root.must_equal "blah"}
        Then { assert_file "config/initializers/buttafly.rb" }
      end
    end

    describe "with model argument" do
Given { skip }
      Given { run_generator ["excel_sheet"] }

      describe "must create buttafly.rb initializer in host app" do

        Then { assert_file "config/initializers/buttafly.rb" }
        # Then { assert_file "config/initializers/buttafly.rb", /ExcelSheet/ }
        # And { }
      end
    end
  end
end


    # describe "must " do
  # end
# end


  # end
#
#     describe "must create engine_routes.rb in config/routes/" do
#
#       Then { assert_file Rails.root.join("config/routes") }
#       And { assert_file Rails.root.join("config/routes/engine_routes.rb") }
#     end
#
#     describe "must add routes/ folder to autoload path" do
#
#       Given(:file) { "config/application.rb" }
#       Given(:line)  { %q[config.autoload_paths += %W(#{config.root}/config/routes)] }
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
