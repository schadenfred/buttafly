require 'test_helper'

describe "Buttafly::Targetable" do

  subject { Buttafly::Targetable }

  specify "self.parent_ass_with_class_of(model, parent)" do
    subject.parent_ass_with_class_of(:wine, :winery).to_s.must_equal "{:winery=>nil}"
    subject.parent_ass_with_class_of(:review, :reviewer).to_s.must_equal "{:reviewer=>:user}"
  end

  specify "self.class_name_of(model, parent)" do
    subject.class_name_of(:wine, :winery).must_equal :winery
    subject.class_name_of(:review, :reviewer).must_equal :user
  end

  describe "self.parents_of(model)" do

    specify "User" do
      subject.parents_of(:user).must_equal []
    end

    specify "Review" do
      subject.parents_of(:review).must_equal [{:reviewer => :user },{:wine=>nil}]
    end

    specify "Wine" do
      subject.parents_of(:wine).must_equal [{:winemaker=>:user}, {:winery=>nil}]
    end

    specify "winery" do
      subject.parents_of(:winery).must_equal [{:owner=>:user}]
    end
  end

  describe "self.ancestors_of(model)" do

    specify do
      subject.ancestors_of(:user).must_equal []
      subject.ancestors_of(:winery).must_equal [owner: { user: [] } ]
      subject.ancestors_of(:winery).must_equal read_hash_from_yaml("winery_ancestors")
      subject.ancestors_of(:wine).must_equal read_hash_from_yaml("wine_ancestors")
      subject.ancestors_of(:review).must_equal read_hash_from_yaml("review_ancestors")
    end

    def expected
      # "blah"
      # [{:parent=>:owner, :class_name=>:user}]
    end

    specify do
      subject.dancestors_of(:winery).first.class.must_equal Hash
      # subject.dancestors_of(:review).must_equal "blah"
      # subject.ancestors_of(:winery).must_equal [owner: { user: [] } ]
      # subject.ancestors_of(:winery).must_equal hash_from_yaml("winery")
      # subject.ancestors_of(:wine).must_equal hash_from_yaml("wine")
      # subject.ancestors_of(:review).must_equal hash_from_yaml("review")
    end
  end

  specify "targetabl_columns" do
    subject.targetable_columns("User").must_equal %w(name)
    subject.targetable_columns(:user).must_equal %w(name)
    subject.targetable_columns("Review").must_equal %w(rating content)
  end

  describe "self.models" do

    before do
      Rails.application.eager_load!
    end

    describe "with empty whitelist and blacklist and" do

      Given { Buttafly.whitelisted_models = [] }
      Given { Buttafly.blacklisted_models = [] }

      describe "default originable_model configuration" do

        Given { Buttafly.originable_model = "Spreadsheet" }

        describe "leaves Blacklisted and ExcelSheet models targetable" do

          Given(:expected) { %w[Blacklisted ExcelSheet Review User Wine Winery]}

          Then { subject.models.sort.must_equal expected.sort }
        end
      end

      describe "with ExcelSheet configured" do

        Given { Buttafly.originable_model = "ExcelSheet" }

        describe "leaves Blacklisted and ExcelSheet models targetable" do

          Given(:expected) { %w[Blacklisted Review User Wine Winery] }

          Then { subject.models.sort.must_equal expected.sort }
        end
      end
    end

    describe "with whitelist of three models" do

      Given { Buttafly.whitelisted_models = %w(wine Winery Review) }
      Given { Buttafly.blacklisted_models = [] }

      Given(:expected) { [:review, :wine, :winery] }

      Then { subject.models.sort.must_equal expected.sort }
    end

    describe "with whitelist of three models" do

      Given { Buttafly.blacklisted_models = %w(Blacklisted ExcelSheet) }
      Given { Buttafly.whitelisted_models = [] }
      Given(:expected) { %w[Review Wine Winery User] }

      Then { subject.models.sort.must_equal expected.sort }
    end
  end
end



#   describe "class methods" do
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
