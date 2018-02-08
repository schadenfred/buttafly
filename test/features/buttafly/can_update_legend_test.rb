require "test_helper"

feature "CanUpdateLegend" do
  scenario "for user model and parents" do
    spreadsheet = buttafly_legends(:one)
    legend = buttafly_legends(:one)
    visit buttafly.edit_legend_path(legend)
    select "rating", from: 'legend_data_review_rating'
    select "review content", from: 'legend_data_review_content'
    select "wine name", from: 'legend_data_review_wine_name'
    select "vintage", from: 'legend_data_review_wine_vintage'
    select "winemaker name", from: 'legend_data_review_wine_winemaker_name'
    select "winery name", from: 'legend_data_review_wine_winery_name'
    select "", from: 'legend_data_review_wine_winery_mission'
    select "", from: 'legend_data_review_wine_winery_history'
    select "reviewer name", from: 'legend_data_review_reviewer_name'
    select "winery owner", from: 'legend_data_review_wine_winery_owner_name'

    click_button "Update Legend"
  end
end
