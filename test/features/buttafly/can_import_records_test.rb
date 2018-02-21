require "test_helper"

feature "CanImportRecords" do
  scenario "for review model and parents" do
    mapping = buttafly_mappings(:review_review)
    visit buttafly.spreadsheet_path(mapping.originable)
    # save_and_open_page
    assert page.has_select?(id: "targetableModel", options: ["review", "wine", "user", "winery"])
    select "review", from: "targetableModel"
    click_button "Create new legend"
    page.has_current_path?("/buttafly/legends/*/edit")
  end
end
