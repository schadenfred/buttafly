# require 'test_helper'
# require 'generators/buttafly/buttafly_generator'
#
# module Buttafly
#   class ButtaflyGeneratorTest < Rails::Generators::TestCase
#     tests ButtaflyGenerator
#     include FileManipulationHelpers
#     destination Rails.root.join('tmp/generators')
#     setup :prepare_destination
#
#     test "generator runs without errors" do
#       assert_nothing_raised do
#         run_generator ["arguments"]
#       end
#     end
#
#     test "creates buttafly.rb in dummy app" do
#       run_generator
#       assert_file "config/initializers/buttafly.rb"
#     end
#
#     test "add buttafly route Gemfile" do
#       filename = Rails.root.join "config/routes.rb"
#       mounter = "mount Buttafly::Engine => \"/buttafly\""
#       gsub_file(filename, mounter, '')
#       run_generator
#       assert_file Rails.root.join("config/routes.rb"), /Buttafly/
#     end
#     # test "add buttafly gem to Gemfile" do
#     #   run_generator
#     #   assert_file Rails.root.join("config/initializers/assets.rb")
#     #   assert_file Rails.root.join("config/initializers/assets.rb")
#     # end
#
#     describe "generate buttafly.rb" do
#
#       describe "without originable model specified as first arg" do
#
#         describe "configures with default spreadsheet" do
#
#           # Given { run_generator }
#           #
#           # Then { assert_file "config/initializers/buttafly.rb" }
#           # And { assert_file "config/initializers/buttafly.rb", /Spreadsheet/ }
#         end
#       end
#
#       # describe "with originable model specified as first arg" do
#       #
#       #   describe "configures with default spreadsheet" do
#       #
#       #     Given { run_generator ["dick"]}
#       #     Then { assert_file "config/initializers/buttafly.rb", /Dick/ }
#       #   end
#       # end
#     end
#   end
# end
