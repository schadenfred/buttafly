require 'test_helper'

describe "Buttafly::Targetable" do

  subject { Buttafly::Targetable }

  describe "self.parents_of(model)" do

    specify "Review" do
      subject.parents_of(:review).must_equal [:user, :wine, :winery]
    end
  end

  describe "self.ancestors_of(model)" do

    specify "Review" do
      subject.ancestors_of(:review).class.must_equal Hash
      subject.ancestors_of(:review).to_s.must_equal "{:user=>{}, :winery=>{}, :wine=>{...}}"
      subject.ancestors_of(:review).keys.must_equal [:user, :winery, :wine]
      subject.ancestors_of(:review)[:wine].must_equal [:user, :winery, :wine]
    end

  end


  describe "self.models" do

    describe "when whitelist is empty" do

      Given { Buttafly.whitelisted_models = %w() }
      Given(:expected) { ["ExcelSheet", "Review", "User", "Wine", "Winery"]}

      Then { subject.models.sort.must_equal expected.sort }
    end

    describe "when whitelist has three models" do

      Given { Buttafly.whitelisted_models = %w(wine winery review) }
      Given(:expected) { %w(wine winery review)}

      Then { subject.models.sort.must_equal expected.sort }
    end
  end
end



#   # subject { Review }
#
#   describe "class methods" do
#
#     it "must return true for :targetable?" do
#       # subject.targetable?.must_equal true
#     end
#
#     # it "#self.targetable_ignored_columns" do
#     #   assert_equal %w[updated_at created_at id], subject.targetable_ignored_columns
#     # end
#     #
#     # it "#self.targetable_columns" do
#     #   expected = %w(content rating reviewer_id wine_id)
#     #   actual = subject.targetable_columns
#     #   assert_equal expected, (expected & actual)
#     # end
#     #
#     # it "#self.targetable_attrs()" do
#     #   assert subject.respond_to? :targetable_attrs
#     #   assert_equal %w[rating content], subject.targetable_attrs
#     #   refute_equal %[id reviewer_id wine_id], subject.targetable_attrs
#     # end
#   end
# end
