require 'test_helper'

describe Buttafly::Originable do

  describe "specified as Spreadsheet" do

    Given { Buttafly.setup { |c| c.originable_model = "Buttafly::Spreadsheet" } }
    Then { Buttafly.originable_model.must_equal "Buttafly::Spreadsheet" }
    And { Buttafly::Spreadsheet.originable?.must_equal true}
  end

  describe "spreadsheet" do

    subject { Buttafly::Spreadsheet }

    it "must return true for originable models" do
      subject.originable?.must_equal true
    end
  end
end
