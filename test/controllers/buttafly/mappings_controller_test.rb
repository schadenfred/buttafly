require 'test_helper'

module Buttafly
  describe MappingsController do
    include Engine.routes.url_helpers

    Given(:sheet) { buttafly_spreadsheets(:review) }
    Given(:mapping) { buttafly_mappings(:review_review) }
    Given(:legend) { buttafly_legends(:one) }

    describe "#show" do

      Given { mapping }
      Given { get mapping_url(mapping) }

      Then { assert_response 200 }
    end

    describe "#create" do

      Given(:params) { { params: { mapping: { legend_id: legend.id } } } }
      Given(:request) { post spreadsheet_mappings_url(sheet), params }

      Then { assert_difference('Buttafly::Mapping.count') { request } }
      And { assert_redirected_to sheet }
    end

    describe "#import" do

      Given(:request) { patch import_mapping_url( mapping ) }

      describe "must create records" do

        Then { assert_difference('User.count', 12) { request } }
        And { assert_redirected_to mapping }
      end

      describe "must create artifacts" do

        Then { assert_difference('Buttafly::Artifact.count', 24) { request } }
      end
    end

    describe "#revert" do

      Given { mapping.import! }

      describe "must remove artifacts" do

        Given(:request) { patch revert_mapping_url(mapping) }
        Then { assert_difference('Buttafly::Artifact.count', -24) { request } }
        And { assert_redirected_to sheet }
      end
    end

    describe "#destroy" do

      Given(:request) { delete mapping_url(mapping) }

      Then { assert_difference('Mapping.count', -1) { request } }
      And { assert_redirected_to mappings_url }
    end
  end
end
