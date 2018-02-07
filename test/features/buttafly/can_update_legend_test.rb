require "test_helper"

feature "CanUpdateLegend" do
  scenario "for review model" do
    legend = buttafly_legends(:one)
    assert_equal legend.data.first.first, "review"
    assert_equal legend.data["review"]["wine"]["winery"]["owner"]["name"], "winery owner"
    visit buttafly.edit_legend_path(legend)
    select "winemaker name", from: '_legend_data_review_wine_winery_owner_name'
    click_button "Save"
    legend.reload.data["review"]["wine"]["winery"]["owner"]["name"].must_equal "winemaker name"
    # save_and_open_page
    #   select "review", from: "targetableModel"
    #   click_button "write new legend"
    #   select "rating", from: '_legend_data_review_rating'
    #   select "review content", from: '_legend_data_review_content'
    #   select "wine name", from: '_legend_data_review_wine_name'
    #   select "vintage", from: '_legend_data_review_wine_vintage'
    #   select "winemaker name", from: '_legend_data_review_wine_winemaker_name'
    #   select "winery name", from: '_legend_data_review_wine_winery_name'
    #   select "", from: '_legend_data_review_wine_winery_mission'
    #   select "", from: '_legend_data_review_wine_winery_history'
    #   select "reviewer name", from: '_legend_data_review_reviewer_name'
    #
    # Buttafly::Legend.last.data.first.first.must_equal "review"
    # Buttafly::Legend.last.targetable_model.must_equal "review"
    # Buttafly::Legend.last.originable_headers.must_include "wine name"
  end
end
