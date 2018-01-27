require 'test_helper'

module Buttafly
  class MappingsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @mapping = buttafly_mappings(:one)
    end

    test "should get index" do
      get mappings_url
      assert_response :success
    end

    test "should get new" do
      get new_mapping_url
      assert_response :success
    end

    test "should create mapping" do
      assert_difference('Mapping.count') do
        post mappings_url, params: { mapping: {  } }
      end

      assert_redirected_to mapping_url(Mapping.last)
    end

    test "should show mapping" do
      get mapping_url(@mapping)
      assert_response :success
    end

    test "should get edit" do
      get edit_mapping_url(@mapping)
      assert_response :success
    end

    test "should update mapping" do
      patch mapping_url(@mapping), params: { mapping: {  } }
      assert_redirected_to mapping_url(@mapping)
    end

    test "should destroy mapping" do
      assert_difference('Mapping.count', -1) do
        delete mapping_url(@mapping)
      end

      assert_redirected_to mappings_url
    end
  end
end
