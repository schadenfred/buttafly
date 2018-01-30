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
      # <ActionController::Parameters {"utf8"=>"✓", "targetable_model"=>"wine", "commit"=>"write new legend", "controller"=>"buttafly/legends", "action"=>"new", "spreadsheet_id"=>"4"} permitted: false>

      get new_spreadsheet_legend_url(@spreadsheet), params: { targetable_model: "wine"}
      assert_response :success
    end

    def sweet_params
      {
        "legend"=>{
          "data"=>{
            "review"=>{
              "rating"=>"rating",
              "content"=>"review content"
            },
            "user"=>{
              "name"=>"winery owner"
            },
            "wine"=>{
              "name"=>"wine name",
              "vintage"=>"vintage"
            },
            "winery"=>{
              "name"=>"winery name",
              "mission"=>"wine name",
              "history"=>"wine name"
            }
          }
        }
      }
    end

    test "should create legend" do

      assert_difference('Legend.count') do
        post legends_url, params: sweet_params
      end

      assert_redirected_to legend_url(Legend.last)
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
skip
      patch legend_url(@legend), params: { legend: {  } }
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
