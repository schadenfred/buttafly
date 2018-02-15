require "test_helper"

feature "CanUploadSpreadsheet" do
  scenario "the test is sound" do
    visit buttafly.root_path
    page.must_have_content "Buttafly"
    click_link "New Spreadsheet"
    fill_in "spreadsheet[name]", with: "sweet name"
    attach_file('spreadsheet[flat_file]', File.absolute_path('./test/samples/reviews.csv'))
    click_button "Create Spreadsheet"
    page.has_current_path?("/buttafly/spreadshets/*")
  end
end
