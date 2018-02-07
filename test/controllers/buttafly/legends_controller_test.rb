require 'test_helper'

module Buttafly
  class LegendsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    Given(:sheet) { buttafly_spreadsheets(:review) }
    Given(:legend) { buttafly_legends(:one) }

    setup do
      @spreadsheet = buttafly_spreadsheets(:review)
      @legend = buttafly_legends(:one)
    end

    describe "#index" do

      When { get legends_url }

      Then { assert_response 200 }
    end

    describe "#new" do

      Given(:params) { { targetable_model: "wine" } }

      When { get new_spreadsheet_legend_url(@spreadsheet), params: params }

      Then { assert_response 200 }
    end

    # describe "#create" do
    #
    #   Given(:params) { { legend: { data: read_hash_from_yaml("review_legend_data") } } }
    #   Given(:actual) { JSON.parse(Legend.last.data)["review"]["reviewer"]["name"] }
    #
    #   Then { assert_difference('Legend.count') {
    #     post legends_url, params: params } }
    #   And { assert_redirected_to legend_url(Legend.last) }
    #   And { assert_equal actual, "reviewer name" }
    # end

    describe "#edit" do

      When { get edit_legend_url(legend) }

      Then { assert_response :success }
    end

    describe "#update" do

      Given(:data) { { data: { "review" => "blah" } } }

      When { patch legend_url(@legend), params: { legend: data } }

      Then { assert_equal @legend.reload.data.first.first, "review" }
      And { assert_redirected_to legend_url(@legend) }
    end

    describe "#destroy" do

      Given(:make_request) { delete legend_url(@legend) }

      Then { assert_difference('Legend.count', -1) { make_request } }
      And { assert_redirected_to legends_url }
    end
  end
end
