require 'test_helper'

module Buttafly
  describe MappingsController do
    include Engine.routes.url_helpers

    Given(:sheet) { buttafly_spreadsheets(:review) }
    Given(:mapping) { buttafly_mappings(:one) }
    Given(:legend) { buttafly_legends(:one) }

    describe "#create" do

      Given(:params) { { params: { mapping: { legend_id: legend.id } } } }
      Given(:request) { post spreadsheet_mappings_url(sheet), params }

      Then { assert_difference('Buttafly::Mapping.count') { request } }
      And { assert_redirected_to sheet }
    end

    describe "#import" do

      Given(:params) { { mapping: { legend_id: legend.id } } }
      Given(:request) { patch import_mapping_url( mapping ) }
      Then { assert_difference('User.count', 12) { request } }
      And { assert_redirected_to sheet }
    end

    describe "#destroy" do

      Given(:request) { delete mapping_url(mapping) }

      Then { assert_difference('Mapping.count', -1) { request } }
      And { assert_redirected_to mappings_url }
    end
  end
end
