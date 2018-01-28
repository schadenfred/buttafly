require "test_helper"

feature "CanUploadSpreadsheet" do
  scenario "the test is sound" do
    visit buttafly.root_path
    page.must_have_content "Buttafly"
  end
end

feature "CanCreateLegend" do
  scenario "for usermodel and parents" do
skip
    spreadsheet = buttafly_spreadsheets(:review)
    visit buttafly.spreadsheet_path(spreadsheet)
    # Buttafly.originable_model = Buttafly::Spreadsheet
    page.select "user", from: "targetable_model"
    click_button "Save"
    # save_and_open_page
  end
end
