# require 'test_helper'
#
# module Buttafly
#   class SpreadsheetsControllerTest < ActionDispatch::IntegrationTest
#     include Engine.routes.url_helpers
#
#     setup do
#       @spreadsheet = buttafly_spreadsheets(:one)
#     end
#
#     test "should get index" do
#       get spreadsheets_url
#       assert_response :success
#     end
#
#     test "should get new" do
#       get new_spreadsheet_url
#       assert_response :success
#     end
#
#     test "should create spreadsheet" do
#       assert_difference('Spreadsheet.count') do
#         post spreadsheets_url, params: { spreadsheet: { aasm_state: @spreadsheet.aasm_state, flat_file: @spreadsheet.flat_file, imported_at: @spreadsheet.imported_at, mtime: @spreadsheet.mtime, name: @spreadsheet.name, processed_at: @spreadsheet.processed_at, uploader_id: @spreadsheet.uploader_id } }
#       end
#
#       assert_redirected_to spreadsheet_url(Spreadsheet.last)
#     end
#
#     test "should show spreadsheet" do
#       get spreadsheet_url(@spreadsheet)
#       assert_response :success
#     end
#
#     test "should get edit" do
#       get edit_spreadsheet_url(@spreadsheet)
#       assert_response :success
#     end
#
#     test "should update spreadsheet" do
#       patch spreadsheet_url(@spreadsheet), params: { spreadsheet: { aasm_state: @spreadsheet.aasm_state, flat_file: @spreadsheet.flat_file, imported_at: @spreadsheet.imported_at, mtime: @spreadsheet.mtime, name: @spreadsheet.name, processed_at: @spreadsheet.processed_at, uploader_id: @spreadsheet.uploader_id } }
#       assert_redirected_to spreadsheet_url(@spreadsheet)
#     end
#
#     test "should destroy spreadsheet" do
#       assert_difference('Spreadsheet.count', -1) do
#         delete spreadsheet_url(@spreadsheet)
#       end
#
#       assert_redirected_to spreadsheets_url
#     end
#   end
# end
