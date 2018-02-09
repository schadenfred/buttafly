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

  describe "validations" do

    Given(:sheet) { buttafly_spreadsheets( :review ) }
    Given(:duplicate) { buttafly_spreadsheets( :duplicate ) }

    describe "uniqueness of name" do

      Given { sheet.save }

      Then { duplicate.valid?.wont_equal true }
    end
  end

  describe "uploader" do

    Given(:sheet) { Buttafly::Spreadsheet.new }
    Given { sheet.flat_file = File.open('test/samples/reviews.csv') }

    describe "has a flat_file of some kind stored" do

      Then { assert File.exists?(sheet.flat_file.file.path) }
    end
  end
end
