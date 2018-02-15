require 'test_helper'

describe Buttafly::Mapping do

  subject { Buttafly::Mapping }

  describe "db" do

    specify "columns & types" do

      must_have_column(:aasm_state, :string)
      must_have_column(:legend_id, :integer)
      must_have_column(:originable_id, :integer)
      must_have_column(:originable_type)
      must_have_column(:aasm_state)
    end

    specify "indexes" do

      must_have_index(["originable_id", "originable_type"])
    end

    specify "associations" do

      must_belong_to(:legend)
      must_belong_to(:originable)

      must_have_many(:artifacts)
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

    describe "#create_artifact" do

      describe "from new" do

        Given(:attrs) { { name: "Cool name" } }
        Given(:stimulus) { mapping.create_artifact("user", attrs)  }
        Given(:expected) { { "user"=>{ :name=>"Cool name" } } }

        Then { assert_difference("Buttafly::Artifact.count") { stimulus } }
        And { Buttafly::Artifact.last.data.must_equal expected }
        And { Buttafly::Artifact.last.is_new?.must_equal true }
      end
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

    Given(:csv_row) { CSV.open(sheet.flat_file.path, headers:true).readlines.first}

    describe "with no parents, targetable User" do

      When(:mapping) { buttafly_mappings(:review_user) }

      Then { assert_difference("User.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Review.count") { mapping.create_records(csv_row) } }
    end

    describe "with parent, targetable Winery" do

      When(:mapping) { buttafly_mappings(:review_winery) }

      Then { assert_difference("User.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Review.count") { mapping.create_records(csv_row) } }
    end

    describe "with parent and grandparents, targetable Wine" do

      When(:mapping) { buttafly_mappings(:review_wine) }

      Then { assert_difference("User.count", 2) { mapping.create_records(csv_row) } }
      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Review.count") { mapping.create_records(csv_row) } }
    end

    describe "great grandparents" do

      When(:mapping) { buttafly_mappings(:review_review) }

      Then { assert_difference("User.count", 3) { mapping.create_records(csv_row) } }
      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Review.count") { mapping.create_records(csv_row) } }
    end

    describe "#transmogrify must create records in all models for each row" do

      Then { assert_difference("Review.count", 4) { mapping.transmogrify } }
      Then { assert_difference("Wine.count", 4) { mapping.transmogrify } }
      Then { assert_difference("Winery.count", 4) { mapping.transmogrify } }
      Then { assert_difference("User.count", 12) { mapping.transmogrify } }
    end
  end

  describe "states" do

    describe "initial must be :importable" do

      Then { mapping.importable?.must_equal true }
    end

    describe "permissions for" do
    end
  end
end
