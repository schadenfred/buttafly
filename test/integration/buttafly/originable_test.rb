require 'test_helper'

module Buttafly
  class OriginableTest < ActionDispatch::IntegrationTest

    describe "specified as Spreadsheet" do

      Given { Buttafly.setup { |c| c.originable_model = "Spreadsheet" } }
    end

    describe "specified as spreadsheet is titleized" do

      Given { Buttafly.setup { |c| c.originable_model = "ExcelSheet" } }
      Then { Buttafly.originable_model.must_equal "ExcelSheet" }
    end
  end
end
