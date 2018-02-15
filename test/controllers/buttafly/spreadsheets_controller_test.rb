require 'test_helper'

module Buttafly
  class SpreadsheetsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    Given(:spreadsheet) { buttafly_spreadsheets(:review) }

    describe "#index" do

      Given { get spreadsheets_url }

      Then { assert_response 200 }
    end

    describe "#new" do

      Given { get new_spreadsheet_url }

      Then { assert_response 200 }
    end

    describe "#create" do

      Given(:attrs) { { name: "cool name", flat_file: sample_csv }}
      Given(:request) { post spreadsheets_url, params: { spreadsheet: attrs } }

      Then { assert_difference('Spreadsheet.count') { request } }
      And { assert_redirected_to spreadsheet_url(Spreadsheet.last) }
    end

    describe "#show" do

      Given { spreadsheet }
      Given { get spreadsheet_url(spreadsheet) }

      Then { assert_response 200 }
    end

    describe "#edit" do

      Given { get edit_spreadsheet_url(spreadsheet) }

      Then { assert_response 200 }
    end

    describe "#update" do

      Given { spreadsheet }
      Given { patch spreadsheet_url(spreadsheet), params: { spreadsheet: { name: "newname" } } }

      Then { assert_response 302 }
      And { spreadsheet.reload.name.must_equal "newname"}
    end

    describe "#delete" do

      # Then { assert_difference('Spreadsheet.count', -1) do
      #        delete spreadsheet_url(spreadsheet)
      #      end
      #  }
      #  end


          # And { assert_redirected_to root_url }

    # test "should destroy spreadsheet" do
    #   @spreadsheet = Spreadsheet.create(flat_file: Rails.root.join('test/samples/reviews.csv'))
    #   assert_difference('Spreadsheet.count', -1) do
    #     delete spreadsheet_url(@spreadsheet)
    #   end

      # assert_redirected_to spreadsheets_url
    end
  end
end
