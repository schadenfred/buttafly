require "test_helper"

feature "CanConfigureOriginableModel" do
  scenario "the test is sound" do

    setup do
      Buttafly.setup do |c|
        c.testingvar = nil
      end
    end

    visit "/buttafly"
    page.must_have_content "Content"
    Buttafly.testingvar.must_equal "blah"
    # page.must_have_content "configurable model is Spreadsheet"
  #   page.wont_have_content "Goodbye All!"
  end
end
