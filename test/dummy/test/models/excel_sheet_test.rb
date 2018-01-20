require 'test_helper'

describe ExcelSheet do

  subject { ExcelSheet }
  
  describe "associations" do

    specify "belongs to" do

      must_have_many(:mappings)
      must_have_many(:legends)
    end
  end

  describe "originable? must be true" do

    Then { subject.originable?.must_equal true}
  end
end
