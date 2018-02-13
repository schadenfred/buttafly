require 'test_helper'

describe Buttafly::Mapping do

  subject { Buttafly::Mapping }

  describe "db" do

    specify "columns & types" do

      must_have_column(:aasm_state, :string)
      must_have_column(:legend_id, :integer)
      must_have_column(:originable_id, :integer)
    end

    specify "indexes" do

      must_have_index(["originable_id", "originable_type"])
    end

    specify "associations" do

      must_belong_to(:legend)
      must_belong_to(:originable)
    end
  end

  Given(:mapping) { buttafly_mappings(:one) }

  describe "can belong to a spreadsheet through polymorphism" do

    Then { mapping.originable.class.name.must_equal "Buttafly::Spreadsheet" }
    And { mapping.legend.class.name.must_equal "Buttafly::Legend" }
  end

  Given(:mapping) { buttafly_mappings(:review_review) }
  Given(:legend) { buttafly_legends(:review) }
  Given(:sheet) { buttafly_spreadsheets(:review) }

  describe "utility methods" do

    Then { mapping.originable.must_equal sheet }
    And { mapping.legend.must_equal legend }

    describe "headers" do

      Then { mapping.headers.must_equal sheet.originable_headers}
    end

    describe "data" do

      Then { mapping.data.must_equal legend.data }
    end

    describe "targetable_models" do

      Given(:expected) { [:wine, :winery, :review, :user] }

      Then { mapping.targetable_models.must_equal expected }
    end
  end

  describe "ancestors" do

    Then { mapping.ancestors.first.keys.first.must_equal :reviewer }
  end

  describe "#create_records" do

    describe "no parents" do
Given { skip }

      Given(:mapping) { buttafly_mappings(:review_review) }
      Given(:csv_row) { csv = CSV.open(sheet.flat_file.path, headers:true).readlines.first}

      Then { assert_difference("User.count") { mapping.create_records(csv_row) } }
    end

    describe "parents" do
Given { skip }

      Given(:mapping) { buttafly_mappings(:review_winery) }
      Given(:csv_row) { csv = CSV.open(sheet.flat_file.path, headers:true).readlines.first}

      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
    end

    describe "grandparents" do
Given { skip }
      Given(:mapping) { buttafly_mappings(:review_wine) }
      Given(:csv_row) { csv = CSV.open(sheet.flat_file.path, headers:true).readlines.first}

      Then { assert_difference("Wine.count") { mapping.create_records(csv_row) } }
    end

    describe "great grandparents" do

      Given(:mapping) { buttafly_mappings(:review_review) }
      Given(:csv_row) { csv = CSV.open(sheet.flat_file.path, headers:true).readlines.first}

      # Given { mapping.create_records(csv_row) }
      # Then { byebug}
      Then { assert_difference("Review.count") { mapping.create_records(csv_row) } }
      # Then { assert_difference("Review.count") { mapping.create_records(csv_row) } }
      # And { Review.count.must_equal 1 }
      # And { Wine.count.must_equal 1 }
      # And { Winery.count.must_equal 1 }

      And { User.pluck(:name).must_equal ["madonna", "joe montana", "jim klein"] }
    end
  end

  describe "#create_records_from_csv_row" do
  end

  describe "create records" do

    describe "without parents" do

      # Then {
      #   assert_difference('User.count') {
      #     # byebug
      #     mapping.transmogrify!
      #   }
      # }
    end
  end
  describe "#transmogrify!" do

    describe ":create_records" do
      # Given(:mapping)

    end
  end
#   it "" do
#     file.mappings.create(FactoryGirl.attributes_for(
#           :mapping_without_parents))
#         file.create_records!
#         Winery.count.must_equal 5
#   end
#
#   it "with one parent" do
#     file.mappings.create(FactoryGirl.attributes_for(:mapping_with_parent))
#     file.create_records!
#     # Winery.count.must_equal 5
#     Wine.count.must_equal 5
#   end
#
#   describe "must create" do
#
#     it "target objects" do
#       file.transmogrify!
#       Review.count.must_equal 1
#     end
#
#     it "parent_objects" do
#     end
#   end
#
#   describe "#import!" do
#
#     # let(:file) { create(:uploaded_file) }
#
# #         it "#convert_data_to_json!" do
# #           file.convert_data_to_json!
# #           file.data.first["child name"].must_equal "ella mac"
# #           file.data.first["parent name"].must_equal "sara"
# #           file.data.first["grandparent name"].must_equal "kc shekhar"
# #         end
#
# #         it "must populate data column with json" do
# #           file.import!
# #           file.data.first.wont_equal nil
# #           file.data.size.must_equal 2
# #           file.aasm_state.must_equal "imported"
  # end
end
