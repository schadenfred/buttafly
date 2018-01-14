require 'test_helper'

module Buttafly
  class ContentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      # @content = excelsheets(:one)
    end

    test "should get index" do
      get contents_url
      assert_response :success
    end
#
#     # test "should get new" do
#     #   get new_content_url
#     #   assert_response :success
#     # end
#     #
#     # test "should create content" do
#     #   assert_difference('Content.count') do
#     #     post contents_url, params: { content: {  } }
#     #   end
#     #
#     #   assert_redirected_to content_url(Content.last)
#     # end
#     #
#     # test "should show content" do
#     #   get content_url(@content)
#     #   assert_response :success
#     # end
#     #
#     # test "should get edit" do
#     #   get edit_content_url(@content)
#     #   assert_response :success
#     # end
#     #
#     # test "should update content" do
#     #   patch content_url(@content), params: { content: {  } }
#     #   assert_redirected_to content_url(@content)
#     # end
#     #
#     # test "should destroy content" do
#     #   assert_difference('Content.count', -1) do
#     #     delete content_url(@content)
#     #   end
#     #
#     #   assert_redirected_to contents_url
#     # end
  end
end
