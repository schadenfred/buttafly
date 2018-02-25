# require "test_helper"
#
# feature "CanCreateLegend" do
#   scenario "for user model and parents" do
#     ActiveRecord::Base.reflect_on_all_associations
#     spreadsheet = buttafly_spreadsheets(:review)
#     visit buttafly.spreadsheet_path(spreadsheet)
#     assert page.has_select?(id: "targetableModel", options: ["review", "wine", "user", "winery"])
#     select "review", from: "targetableModel"
#     click_button "Create new legend"
#     page.has_current_path?("/buttafly/legends/*/edit")
#   end
# end
