require 'test_helper'
require 'generators/buttafly/buttafly_generator'

module Buttafly
  class ButtaflyGeneratorTest < Rails::Generators::TestCase
    tests ButtaflyGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    specify "generator runs without errors" do
      assert_nothing_raised do
        run_generator ["arguments"]
      end
    end

    describe "generate buttafly.rb" do

      describe "without originable model specified as first arg" do

        describe "configures with default spreadsheet" do

          Given { run_generator }

          Then { assert_file "config/initializers/buttafly.rb" }
          And { assert_file "config/initializers/buttafly.rb", /Spreadsheet/ }
        end
      end

      describe "with originable model specified as first arg" do

        describe "configures with default spreadsheet" do

          Given { run_generator ["dick"]}
          Then { assert_file "config/initializers/buttafly.rb" }
          Then { assert_file "config/initializers/buttafly.rb", /Dick/ }
        end
      end
    end
  end
end
