require 'test_helper'

module Buttafly
  class OriginableModelsTest < ActionDispatch::IntegrationTest

        # setup do
        #   Buttafly.setup do |c|
        #     # c.testingvar = nil
        #   end
        # end

    describe "No configuration" do

      # Given { Buttafly.setup { |c| c.originable_model = nil } }
      # Then { Buttafly.originable_model.must_equal "Spreadsheet" }
    end

    describe "specified as Spreadsheet" do

      Given { Buttafly.setup { |c| c.originable_model = "Spreadsheet" } }
      # Then { Buttafly.originable_model.must_equal "Spreadsheet" }
    end

    describe "specified as spreadsheet is titleized" do

      Given { Buttafly.setup { |c| c.originable_model = "lowerkasesel" } }
      # Then { Buttafly.originable_model.must_equal "Spreadsheet" }
    end


    # visit "/buttafly"
    # page.must_have_content "Content"
    # page.must_have_content "configurable model is Spreadsheet"
    # page.wont_have_content "Goodbye All!"
  end
end


    # test "the truth" do


    #   assert true
    # end
#   end
# end
