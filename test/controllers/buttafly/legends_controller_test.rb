require 'test_helper'

module Buttafly
  class LegendsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @legend = buttafly_legends(:one)
    end

    test "should get index" do
      get legends_url
      assert_response :success
    end

    test "should get new" do
      get new_legend_url
      assert_response :success
    end

    test "should create legend" do
      assert_difference('Legend.count') do
        post legends_url, params: { legend: {  } }
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
