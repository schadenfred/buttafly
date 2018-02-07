require "test_helper"

feature "CanUploadSpreadsheet" do
  scenario "the test is sound" do
    visit buttafly.root_path
    page.must_have_content "Buttafly"
  end
end

feature "CanCreateLegend" do
  scenario "for user model and parents" do
    spreadsheet = buttafly_spreadsheets(:review)
    visit buttafly.spreadsheet_path(spreadsheet)
    assert_difference('Buttafly::Legend.count') do
      select "review", from: "targetableModel"
      click_button "write new legend"
      select "rating", from: '_legend_data_review_rating'
      select "review content", from: '_legend_data_review_content'
      select "wine name", from: '_legend_data_review_wine_name'
      select "vintage", from: '_legend_data_review_wine_vintage'
      select "winemaker name", from: '_legend_data_review_wine_winemaker_name'
      select "winery name", from: '_legend_data_review_wine_winery_name'
      select "", from: '_legend_data_review_wine_winery_mission'
      select "", from: '_legend_data_review_wine_winery_history'
      select "reviewer name", from: '_legend_data_review_reviewer_name'
      select "winery owner", from: '_legend_data_review_wine_winery_owner_name'
      click_button "create legend"
    end

    Buttafly::Legend.last.data.first.first.must_equal "review"
    Buttafly::Legend.last.targetable_model.must_equal "review"
    Buttafly::Legend.last.originable_headers.must_include "wine name"
  end
end
