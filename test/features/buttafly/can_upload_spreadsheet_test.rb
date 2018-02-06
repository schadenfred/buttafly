require "test_helper"

feature "CanUploadSpreadsheet" do
  scenario "the test is sound" do
    visit buttafly.root_path
    page.must_have_content "Buttafly"
  end
end

feature "CanCreateLegend" do
  scenario "for user model and parents" do
    assert_difference('Buttafly::Legend.count') do
      spreadsheet = buttafly_spreadsheets(:review)
      visit buttafly.spreadsheet_path(spreadsheet)
      select "review", from: "targetable_model"
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

    expected = read_hash_from_yaml("review_legend_data")
    JSON.parse(Buttafly::Legend.last.data).must_equal expected
  end
end
