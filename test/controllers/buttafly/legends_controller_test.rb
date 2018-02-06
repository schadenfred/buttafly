require 'test_helper'

module Buttafly
  class LegendsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @spreadsheet = buttafly_spreadsheets(:review)
      @legend = buttafly_legends(:one)
    end

    test "should get index" do
      get legends_url
      assert_response :success
    end

    test "should get new" do

      get new_spreadsheet_legend_url(@spreadsheet), params: { targetable_model: "wine"}
      assert_response :success
    end

    test "should create legend" do
      assert_difference('Legend.count') do
        post legends_url, params: { legend: { data: read_hash_from_yaml("review_legend_data") } }
      end

      assert_redirected_to legend_url(Legend.last)
      assert_equal JSON.parse(Legend.last.data)["review"]["reviewer"]["name"], "reviewer name"
    end

    test "should show legend" do
      get legend_url(@legend)
      assert_response :success
    end

    test "should get edit" do
      get edit_legend_url(@legend)
      assert_response :success
    end

    test "should update legend" do

      patch legend_url(@legend), params: { legend: { data: { "sweet data" => "blah"} } }
      assert_redirected_to legend_url(@legend)
    end

    test "should destroy legend" do
      assert_difference('Legend.count', -1) do
        delete legend_url(@legend)
      end

      assert_redirected_to legends_url
    end
  end
end
