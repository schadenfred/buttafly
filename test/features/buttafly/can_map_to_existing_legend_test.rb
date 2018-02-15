require "test_helper"

feature "CanMapToExistingLegend " do
  scenario "for user model and parents" do
    spreadsheet = buttafly_spreadsheets(:review)
    legend = buttafly_legends(:one)
    spreadsheet.mappings.delete_all
    visit buttafly.spreadsheet_path(spreadsheet)
    select "user", from: "existingLegend"
    click_button "Choose from existing legend"
    page.has_current_path?("/buttafly/spreadsheets(spreadsheet)")
  end
end
