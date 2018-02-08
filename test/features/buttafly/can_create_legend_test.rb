require "test_helper"

feature "CanCreateLegend" do
  scenario "for user model and parents" do
    spreadsheet = buttafly_spreadsheets(:review)
    visit buttafly.spreadsheet_path(spreadsheet)
    assert_difference('Buttafly::Legend.count') do

      select "review", from: "targetableModel"
      click_button "begin new legend"
      Buttafly::Legend.last.originable_headers.class.must_equal Array
      Buttafly::Legend.last.originable_headers.must_include "wine name"
      Buttafly::Legend.last.targetable_model.must_equal "review"
      Buttafly::Legend.last.data.nil?.must_equal true
    end
    spreadsheet.reload.legends.last.targetable_model.must_equal "review"
  end
end
