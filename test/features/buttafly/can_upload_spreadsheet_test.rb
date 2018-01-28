# require "test_helper"
#
# feature "CanUploadSpreadsheet" do
#   scenario "the test is sound" do
#     visit buttafly.root_path
#     page.must_have_content "Buttafly"
#   end
# end
#
# feature "parCanCreateLegend" do
#   scenario "for user model and parents" do
#     Buttafly.originable_model = Buttafly::Spreadsheet
#     assert_difference('Buttafly::Legend.count') do
#       spreadsheet = buttafly_spreadsheets(:review)
#       visit buttafly.spreadsheet_path(spreadsheet)
#       page.select "review", from: "targetable_model"
#       click_button "Save"
#       select "rating", from: '_mapping_legend_data_review_rating'
#       click_button "Create legend"
#     end
#   end
# end
