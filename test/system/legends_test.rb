require "application_system_test_case"

class LegendsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit buttafly.spreadsheets_url
    #
    # assert_selector "h1", text: "Legends"
  end
end
