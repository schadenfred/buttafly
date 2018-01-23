require "test_helper"

feature "CanUploadSpreadsheet" do
  scenario "the test is sound" do
    visit buttafly.root_path
    page.must_have_content "Spreadsheets"
  end
end
