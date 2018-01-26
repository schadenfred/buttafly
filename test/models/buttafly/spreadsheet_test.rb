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

  describe "has a flat_file of some kind stored" do
    Given(:spreadsheet) { buttafly_spreadsheets(:spreadsheet_with_flat_file) }
    Then { assert File.exists?(spreadsheet.flat_file.file.path) }
  end

  # test "uploads an avatar" do
  #   user = User.create!(:avatar, fixture_file_upload('/files/tapir.jpg', 'image/jpg'))
  #   assert(File.exists?(user.reload.avatar.file.path))
  # end

  it "#originable_headers must return correct headers" do
    # post :change_avatar, avatar: fixture_file_upload('files/spongebob.png', 'image/png')

    # @spreadsheet = buttafly_spreadsheets(:one)
    # headers = @spreadsheet.originable_headers
    # headers.must_equal %w[wine winery vintage review rating]
  end
end
