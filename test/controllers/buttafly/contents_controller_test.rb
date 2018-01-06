require 'test_helper'

module Buttafly
  class ContentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get contents_index_url
      assert_response :success
    end

  end
end
