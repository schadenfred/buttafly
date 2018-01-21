require 'test_helper'

describe "Buttafly::Targetable" do

  subject { Buttafly::Targetable }

  describe "self.parents_of(model)" do

    specify "User" do
      subject.parents_of(:user).sort.must_equal [].sort
    end

    specify "Review" do
      subject.parents_of(:review).sort.must_equal [:wine, :reviewer].sort
    end

    specify "Wine" do
      subject.parents_of(:wine).sort.must_equal [:winery, :winemaker].sort
    end

    specify "winery" do
      subject.parents_of(:winery).sort.must_equal [:owner]
    end
  end

  describe "self.class_name_of(parent)" do
    specify "User" do
      skip
      subject.class_name_of(:user).must_equal "blah"
    end
  end

  describe "self.ancestors_of(model)" do

    specify "User" do
      skip
      subject.ancestors_of(:user).to_s.must_equal "[]"
      subject.ancestors_of(:user).size.must_equal 0
    end

    specify "Wine" do
skip
      subject.ancestors_of(:wine).to_s.must_equal "[]"
      # subject.ancestors_of(:wine).size.must_equal 2
      # byebug
      # subject.ancestors_of(:user).must_equal {}
      # subject.ancestors_of(:review).to_s.must_equal "{:user=>{}, :winery=>{}, :wine=>{...}}"
      # subject.ancestors_of(:review).keys.must_equal [:user, :winery, :wine]
      # subject.ancestors_of(:review)[:wine].must_equal [:user, :winery, :wine]
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
