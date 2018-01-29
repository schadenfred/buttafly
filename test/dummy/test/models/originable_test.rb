require 'test_helper'

[Buttafly::Spreadsheet, ExcelSheet].each do |originable|

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
      Then { subject.originable?.must_equal true}

      Given(:expected) { buttafly_mappings("#{table_name}_mapping")}

      Then { sheet.mappings.must_include expected }
    end

    describe "has many :legends, through: :mappings" do

      Then {  sheet.legends.must_include buttafly_legends(:one) }
    end

    describe "#originable_headers(file_location) must return correct headers" do

      Given(:excel_sheet_path) {Rails.root.join("../../test/fixtures/files/uploads/buttafly/spreadsheet/flat_file/960725447/reviews.csv")}
      Given(:headers) { (subject == ExcelSheet) ? sheet.originable_headers(excel_sheet_path) : sheet.originable_headers }
      Given(:expected) do ["wine name", "winemaker name", "winery name",
        "vintage", "review content", "rating", "winery owner", "reviewer name"]
      end

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

    describe "#transmogrify!" do

      # let(:file) { FactoryGirl.create(:originable) }
      describe ":create_records" do

        it "without parents" do
  skip
  file.mappings.create(FactoryGirl.attributes_for(
            :mapping_without_parents))
          file.create_records!
          Winery.count.must_equal 5
        end

        it "with one parent" do
skip
          file.mappings.create(FactoryGirl.attributes_for(:mapping_with_parent))
          file.create_records!
          # Winery.count.must_equal 5
          Wine.count.must_equal 5
        end
      end

      describe "must create" do

        it "target objects" do
skip
          file.transmogrify!
          Review.count.must_equal 1
        end

        it "parent_objects" do
skip
        end
      end
    end

    describe "#import!" do

      # let(:file) { create(:uploaded_file) }

#         it "#convert_data_to_json!" do
#           file.convert_data_to_json!
#           file.data.first["child name"].must_equal "ella mac"
#           file.data.first["parent name"].must_equal "sara"
#           file.data.first["grandparent name"].must_equal "kc shekhar"
#         end

#         it "must populate data column with json" do
#           file.import!
#           file.data.first.wont_equal nil
#           file.data.size.must_equal 2
#           file.aasm_state.must_equal "imported"
        end

  end
end
