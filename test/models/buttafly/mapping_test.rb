require 'test_helper'

describe Buttafly::Mapping do

  subject { Buttafly::Mapping }

  describe "db" do

    specify "columns & types" do

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
      Given(:mapping)

    end
  end
#   it "" do
#     skip
#     file.mappings.create(FactoryGirl.attributes_for(
#           :mapping_without_parents))
#         file.create_records!
#         Winery.count.must_equal 5
#   end
#
#   it "with one parent" do
# skip
#     file.mappings.create(FactoryGirl.attributes_for(:mapping_with_parent))
#     file.create_records!
#     # Winery.count.must_equal 5
#     Wine.count.must_equal 5
#   end
#
#   describe "must create" do
#
#     it "target objects" do
# skip
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
