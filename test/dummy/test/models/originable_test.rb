require 'test_helper'

[Buttafly::Spreadsheet].each do |originable|

  describe originable do

    subject { originable }

    describe "associations" do

      specify "belongs to" do

        must_have_many(:mappings)
        must_have_many(:legends)
      end
    end

    def originables_fixture(fixture_name)
      eval("#{subject.table_name}(fixture_name.to_sym)")
    end

    def table_name
      subject.table_name
    end

    Given { Buttafly.originable_model = subject }

    describe "originable? must be true" do

    end

    Given(:sheet) { originables_fixture(:review) }

    describe "has many :mappings" do

      Given(:expected) { buttafly_mappings("#{table_name}_mapping")}

      Then { sheet.mappings.must_include expected }
    end

    describe "has many :legends, through: :mappings" do

      Then {  sheet.legends.must_include buttafly_legends(:one) }
    end

    describe "#originable_headers(file_location) must return correct headers" do

      Given(:headers) { sheet.originable_headers }
      Given(:expected) { [
        "wine name", "winemaker name", "winery name", "vintage",
        "review content", "rating", "winery owner", "reviewer name"]}

      Then { headers.must_equal expected }
    end

    describe "states" do

      describe "initial must be :uploaded" do

        Then { sheet.uploaded?.must_equal true }
      end

      describe "permissions for" do

        Given(:spreadsheet) { subject.new }

        describe ":uploaded" do

          Given { spreadsheet.aasm_state = "uploaded" }

          Then { spreadsheet.may_map?.must_equal true }
          And { spreadsheet.may_import?.must_equal false }
          And { spreadsheet.may_archive?.must_equal true }
        end

        describe ":mapped" do

          Given { spreadsheet.aasm_state = "mapped"}

          Then { spreadsheet.may_map?.must_equal true }
          And { spreadsheet.may_import?.must_equal true }
          And { spreadsheet.may_archive?.must_equal true }
        end

        describe ":imported" do

          Given { spreadsheet.aasm_state = "imported"}

          Then { spreadsheet.may_map?.must_equal true }
          And { spreadsheet.may_import?.must_equal false }
          And { spreadsheet.may_archive?.must_equal true }
        end
      end
    end

    describe "#legend_candidates" do
      
      Given(:candidate)  { buttafly_legends(:review) }
      Given(:noncandidate) { buttafly_legends(:one) }
      Given { noncandidate.update(originable_headers: ["bogus", "headers"]) }

      Then { sheet.legend_candidates.must_include candidate }
      And { sheet.legend_candidates.wont_include noncandidate }
    end
  end
end
