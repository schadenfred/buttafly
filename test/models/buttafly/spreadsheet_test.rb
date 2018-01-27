require 'test_helper'

describe Buttafly::Spreadsheet do

  subject { Buttafly::Spreadsheet }

  describe "db" do

    specify "columns & types" do

      must_have_column(:name)
      must_have_column(:flat_file)
      must_have_column(:aasm_state)
      must_have_column(:uploader_id, :integer)
      must_have_column(:imported_at, :datetime)
      must_have_column(:processed_at, :datetime)
      must_have_column(:row_count, :integer)
    end
  end

  describe "associations" do

    specify "belongs to" do

      must_have_many(:mappings)
      must_have_many(:legends)
    end
  end

  describe "Originable" do
    Given(:sheet) { Buttafly::Spreadsheet.new }
    Given { sheet.flat_file = File.open('test/samples/reviews.csv') }

    describe "has a flat_file of some kind stored" do

      Then { assert File.exists?(sheet.flat_file.file.path) }
    end

    describe "#originable_headers(file_location) must return correct headers" do

      Given(:headers) { sheet.originable_headers }

      Then { headers.must_equal %w[wine winery vintage review rating] }
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
  #         end
        end
      end
    end
  end
end
