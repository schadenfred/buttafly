require "test_helper"

feature "CanDestroyLegend" do
  scenario "for user model and parents" do
    mapping = buttafly_mappings(:review_review)
    visit buttafly.edit_legend_path(mapping.legend)
    click_button "Destroy legend"
    page.has_current_path?("/buttafly")
  end
end
