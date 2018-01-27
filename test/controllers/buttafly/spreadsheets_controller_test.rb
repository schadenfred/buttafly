require 'test_helper'

module Buttafly
  class SpreadsheetsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @spreadsheet = buttafly_spreadsheets(:review)
    end

    test "should get index" do
      get spreadsheets_url
      assert_response :success
    end

    test "should get new" do
      get new_spreadsheet_url
      assert_response :success
    end

    test "should create spreadsheet" do
      assert_difference('Spreadsheet.count') do
        post spreadsheets_url, params: { spreadsheet: { name: @spreadsheet.name } }
      end

      assert_redirected_to root_url
    end

    test "should show spreadsheet" do
      get spreadsheet_url(@spreadsheet)
      assert_response :success
    end

    test "should get edit" do
      get edit_spreadsheet_url(@spreadsheet)
      assert_response :success
    end

    test "should update spreadsheet" do
      patch spreadsheet_url(@spreadsheet), params: { spreadsheet: { name: "newname" } }
      assert_response 302
    end

    test "should destroy spreadsheet" do
      @spreadsheet = Spreadsheet.create(flat_file: Rails.root.join('test/samples/reviews.csv'))
      assert_difference('Spreadsheet.count', -1) do
        delete spreadsheet_url(@spreadsheet)
      end

      assert_redirected_to spreadsheets_url
    end
  end
end
