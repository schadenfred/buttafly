require 'test_helper'

describe Buttafly::Spreadsheet do

  subject { Buttafly::Spreadsheet }

  describe "db" do

    specify "columns & types" do

      must_have_column(:name)
      must_have_column(:flat_file)
      must_have_column(:aasm_state)
      must_have_column(:uploader_id, :integer)
      must_have_column(:imported_at, :datetime)
      must_have_column(:processed_at, :datetime)
      must_have_column(:row_count, :integer)
    end
  end

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
