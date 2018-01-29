require 'test_helper'

describe ExcelSheet do

  subject { ExcelSheet }

  describe "db" do

    specify "columns & types" do

      must_have_column(:aasm_state)
      must_have_column(:custom_state)
      must_have_column(:sheet)
    end
  end
end
