require 'test_helper'

describe Buttafly::Originable do

  describe "specified as Spreadsheet" do

    Given { Buttafly.setup { |c| c.originable_model = "Spreadsheet" } }
  end

  describe "specified as spreadsheet is titleized" do

    Given { Buttafly.setup { |c| c.originable_model = "ExcelSheet" } }
    Then { Buttafly.originable_model.must_equal "ExcelSheet" }
  end

  describe "spreadsheet" do

    subject { Buttafly::Spreadsheet }

    describe "associations" do

      specify "belongs to" do
      end

      specify "has many" do

        must_have_many(:mappings)
        must_have_many(:legends)
      end
    end

    describe "validations" do

    end

    it "must return true for originable models" do
      subject.originable?.must_equal true
    end

    before do
      @spreadsheet = spreadsheets(:one)
    end
    it "#originable_headers must return correct headers" do
      headers = @spreadsheet.name
      headers.must_equal %w[wine winery vintage review rating]
    end

  end
end
#   it "self.targetable_models" do
#
#     actual = spreadsheet.targetable_models
#     expected = ["DummyChild", "DummyGrandparent", "DummyParent", "DummyTribe",
#                 "Review", "User", "Wine", "Winery"]
#     assert_equal actual, expected
#   end
#
#
#   it "tsorted_order" do
#     spreadsheet.tsorted_order
#   end
#
#   it "self.targetable_parents" do
#     spreadsheet.targetable_parents(:winery).must_equal []
#     spreadsheet.targetable_parents(:user).must_equal []
#     spreadsheet.targetable_parents(:wine).must_equal [:winery]
#     spreadsheet.targetable_parents(:review).must_equal [:user, :wine]
#   end
#
#   it "ancestors_of(klass)" do
#     # spreadsheet.ancestors_of(:winery).must_equal []
#     # spreadsheet.ancestors_of(:user).must_equal []
#     # spreadsheet.ancestors_of(:wine).must_equal [:winery]
#     # spreadsheet.parents_of(:review).must_equal [:user, :wine]
#   end
#
#   it "parents_of(model)" do
#     # spreadsheet.parents_of(:winery).must_equal [[]]
#     # spreadsheet.parents_of(:user).must_equal [[]]
#     spreadsheet.parents_of(:wine).must_equal [:winery]
#     spreadsheet.parents_of(:review).must_equal [:user, :wine]
#   end
#
#   it "tsorted_order" do
#     skip
#     actual = spreadsheet.tsorted_order
#     byebug
#     actual.must_equal []
#   end
#
#   describe "states" do
#
#     specify "initial must be :uploaded" do
#
#       uploaded_file = subject.new
#       uploaded_file.uploaded?.must_equal true
#     end
#
#     describe "permissions for" do
#
#       it ":uploaded" do
#
#         file = build_stubbed(:uploaded_file)
#         file.may_target?.must_equal true
#         file.may_map?.must_equal false
#         file.may_transmogrify?.must_equal false
#       end
#
#       it ":targeted" do
#
#         file = create(:targeted_file)
#         file.may_map?.must_equal true
#         file.may_transmogrify?.must_equal false
#       end
#
#       it ":targeted" do
#
#         file = create(:mapped_file)
#         file.may_transmogrify?.must_equal true
#       end
#     end
#
#     describe "events" do
#
#       describe "#transmogrify!" do
#
#         let(:file) { FactoryGirl.create(:originable) }
#
#         describe ":create_records" do
#
#           it "without parents" do
#     skip        file.mappings.create(FactoryGirl.attributes_for(
#               :mapping_without_parents))
#             file.create_records!
#             Winery.count.must_equal 5
#           end
#
#           it "with one parent" do
# skip
#             file.mappings.create(FactoryGirl.attributes_for(:mapping_with_parent))
#             file.create_records!
#             # Winery.count.must_equal 5
#             Wine.count.must_equal 5
#           end
#         end
#
#         describe "must create" do
#
#           it "target objects" do
#             skip
#             file.transmogrify!
#             Review.count.must_equal 1
#           end
#
#           it "parent_objects" do
#           end
#         end
#       end
#
#       describe "#import!" do
#
#         let(:file) { create(:uploaded_file) }
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
# #         end
#       end
#     end
#   end
# end
