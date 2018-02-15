require 'test_helper'

module Buttafly
  class MappingsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @spreadsheet = buttafly_spreadsheets(:review)
      @mapping = buttafly_mappings(:one)
      @legend = buttafly_legends(:one)
    end

    test "should create mapping" do

      assert_difference('Buttafly::Mapping.count') do
        post spreadsheet_mappings_url(@spreadsheet), params: { mapping: { legend_id: @legend.id } }
      end

      assert_redirected_to @spreadsheet
    end

    test "should destroy mapping" do

      assert_difference('Mapping.count', -1) do
        delete mapping_url(@mapping)
      end

      assert_redirected_to mappings_url
    end
  end
end
