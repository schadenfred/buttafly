require "test_helper"

describe ExcelSheet do
  let(:excel_sheet) { ExcelSheet.new }

  it "must be valid" do
    value(excel_sheet).must_be :valid?
  end
end
