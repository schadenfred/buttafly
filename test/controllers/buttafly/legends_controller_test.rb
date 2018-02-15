require 'test_helper'

module Buttafly
  describe "LegendsController" do

    include Engine.routes.url_helpers

    Given(:sheet) { buttafly_spreadsheets(:review) }
    Given(:legend) { buttafly_legends(:one) }

    describe "#create" do

      Given(:params) { { legend: { targetable_model: "review"}} }
      Given(:request) { post legends_url(spreadsheet_id: sheet), params: params}

      Then { assert_difference(['Legend.count', 'Mapping.count']) { request } }
      And { assert_redirected_to edit_legend_url(Legend.last) }
    end

    describe "#edit" do

      When { get edit_legend_url(legend) }

      Then { assert_response :success }
    end

    describe "#update" do

      Given(:data) { { data: { "review" => "blah" } } }

      When { patch legend_url(legend), params: { legend: data } }

      Then { assert_equal legend.reload.data.first.first, "review" }
      And { assert_redirected_to edit_legend_url(legend) }
    end

    describe "#destroy" do

      Given { buttafly_mappings(:review_review) }
      Given(:count) { legend.mappings.count }
      Given(:make_request) { delete legend_url(legend) }

      Then { assert_difference('Legend.count', -1) { make_request } }
      Then { assert_difference('Mapping.count', count * -1) { make_request } }
      And { assert_redirected_to root_url }
    end
  end
end
