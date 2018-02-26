require "test_helper"

feature "CanImportRecords" do
  scenario "for review model and parents" do
    mapping = buttafly_mappings(:review_review)
    visit buttafly.spreadsheet_path(mapping.originable)
    select "Review", from: "targetableModel"
    click_button "Create new legend"
    page.has_content?("Legend was successfully created.").must_equal true
  end
end
