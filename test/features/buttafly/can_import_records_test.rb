require "test_helper"

feature "CanImportRecords" do
  scenario "for review model and parents" do
    mapping = buttafly_mappings(:review_review)
    visit buttafly.spreadsheet_path(mapping.originable)
    click_button(id: "importMapping-#{mapping.id}")
    page.has_current_path?("/buttafly/mappings/#{mapping.id}").must_equal true
  end
end
