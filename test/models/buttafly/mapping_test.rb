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


  describe "can belong to a spreadsheet through polymorphism" do

    Given(:mapping) { buttafly_mappings(:one) }

    Then { mapping.originable.class.name.must_equal "Buttafly::Spreadsheet" }
    And { mapping.legend.class.name.must_equal "Buttafly::Legend" }
  end

  Given(:mapping) { buttafly_mappings(:review_review) }
  Given(:legend) { buttafly_legends(:review) }
  Given(:sheet) { buttafly_spreadsheets(:review) }
  Given(:artifact_count) { "Buttafly::Artifact.count" }

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

      Given { User.create!(name: "Veronica Dean") }
      Given(:stimulus) { mapping.create_artifact("user", attrs)  }

      describe "from 'new' status is :was_new" do

        Given(:attrs) { { name: "Cool unique name" } }
        Given(:expected) { { "name" => "Cool unique name" } }

        Then { assert_difference(["User.count", artifact_count]) { stimulus } }
        And { Buttafly::Artifact.last.data["user"].must_equal expected }
      end

      describe "from 'duplicate' is :was_dupliate" do

        Given(:attrs) { { name: "Veronica Dean" } }
        Given(:expected) { { "user"=>{ :name=>"Veronica Dean" } } }

        Then { assert_difference(artifact_count) { stimulus } }
        And { assert_no_difference("User.count") { stimulus } }
        And { Buttafly::Artifact.last.status.must_equal "was_duplicate" }
      end

      describe "from 'update' is :was_updated" do

        Given(:attrs) { { name: "Veronica Dean", age: 21, astrological_sign: "taurus" } }
        Given(:expected) { { "user"=>{ :name=>"Veronica Dean" } } }

        Then { assert_difference(artifact_count) { stimulus } }
        And { Buttafly::Artifact.last.status.must_equal "was_updated" }
        And { assert_no_difference("User.count") { stimulus } }
      end
    end

    describe "#findable_attrs(model)" do

      describe "User" do

        Given(:expected) { { "name" => "Garland Maverock" } }
        Given(:attrs) { { "name" => "Garland Maverock", age: 55, astrological_sign: "Cancer" } }

        Then { mapping.findable_attrs(:user, attrs ).must_equal expected}
      end

      describe "wine" do

        Given(:owner) { User.create(name: "Bill Blinker" ) }
        Given(:winery) { Winery.create(name: "Gallo", owner: owner) }
        Given(:attrs) { { "name" => "Ella's Reserve", "vintage" => "2001", "winery_id" => winery.id } }
        Given(:expected) { { "name" => "Ella's Reserve", "winery_id" => 1 }  }

        Then { mapping.findable_attrs(:wine, attrs).must_equal expected}
      end
    end

    describe "targetable_models" do
Given { skip }
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
      Then { refute_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Review.count") { mapping.create_records(csv_row) } }
      Then { assert_difference(artifact_count, 1) { mapping.create_records(csv_row) } }
    end

    describe "with parent, targetable Winery" do

      When(:mapping) { buttafly_mappings(:review_winery) }

      Then { assert_difference("User.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Review.count") { mapping.create_records(csv_row) } }
      Then { assert_difference(artifact_count, 2) { mapping.create_records(csv_row) } }
    end
    describe "with parent and grandparents, targetable Wine" do

      When(:mapping) { buttafly_mappings(:review_wine) }

      Then { assert_difference("User.count", 2) { mapping.create_records(csv_row) } }
      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { refute_difference("Review.count") { mapping.create_records(csv_row) } }
      Then { assert_difference(artifact_count, 4) { mapping.create_records(csv_row) } }
    end

    describe "great grandparents" do

      When(:mapping) { buttafly_mappings(:review_review) }

      Then { assert_difference("User.count", 3) { mapping.create_records(csv_row) } }
      Then { assert_difference("Winery.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Wine.count") { mapping.create_records(csv_row) } }
      Then { assert_difference("Review.count") { mapping.create_records(csv_row) } }
      Then { assert_difference(artifact_count, 6) { mapping.create_records(csv_row) } }
    end

    describe "#transmogrify must create records in all models for each row" do

      Then { assert_difference("Review.count", 4) { mapping.transmogrify } }
      Then { assert_difference("Wine.count", 4) { mapping.transmogrify } }
      Then { assert_difference("Winery.count", 4) { mapping.transmogrify } }
      Then { assert_difference("User.count", 12) { mapping.transmogrify } }
      Then { assert_difference(artifact_count, 24) { mapping.transmogrify } }
    end
  end

  describe "#revert_all_records" do

    Given { mapping.transmogrify }

    Then { assert_difference(artifact_count, -24) { mapping.revert_all_records } }
  end

  describe "#import!" do

    Then { assert_difference(artifact_count, 24) { mapping.import! } }
    And { mapping.aasm_state.must_equal "imported" }
  end

  describe "#revert!" do

    Given { mapping.import! }

    Then { assert_difference(artifact_count, -24) { mapping.revert! } }
    And { mapping.aasm_state.must_equal "importable" }
  end
end
