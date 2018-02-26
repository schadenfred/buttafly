require 'test_helper'

module Buttafly
  class ArtifactTest < ActiveSupport::TestCase

    subject { Buttafly::Artifact}

    describe "db" do

      specify "columns" do
        must_have_column(:data, :text)
        must_have_column(:status, :integer)
      end
    end

    describe "associations" do

      specify "belongs_to" do

        must_belong_to(:mapping)
      end
    end

    Given(:mapping) { buttafly_mappings(:review_review) }
    Given(:artifact_count) { "Buttafly::Artifact.count" }

    describe "#revert_record" do

      Given(:joemontana) { User.where(name: "joe montana").first }
      Given { User.create!(name: "joe montana") }
      Given { mapping.transmogrify }

      describe "from new deletes the artifact and the record" do

        Given(:artifact) { Buttafly::Artifact.where(status: "was_new").last }

        Then do
          assert_difference(["Review.count", artifact_count], -1) do
            artifact.revert_record
          end
        end
      end

      describe "from duplicate deletes the artifact" do

        Given(:artifact) { subject.where(status: "was_duplicate").last }

        Then do
          assert_difference([artifact_count], -1) do
            artifact.revert_record
          end
        end
      end

      describe "from updated" do

        Given(:artifact) { Buttafly::Artifact.where(status: "was_updated").last}
        Given(:attrs) { { name: "joe montana",
                          age: 55,
                          astrological_sign: "taurus" } }
        Given { mapping.create_artifact("user", attrs)  }

        describe "has age and astrological_sign attrs before reversion" do

          Then { joemontana.age.must_equal 55 }
          And { joemontana.astrological_sign.must_equal "taurus" }
        end

        describe "deletes the artifact" do

          Then do assert_difference([artifact_count], -1) do
                 artifact.revert_record
            end
          end
        end

        describe "and reverts the record" do

          Then { assert_no_difference(["User.count"]) { artifact.revert_record}}
          And { joemontana.age.must_be_nil }
          And { joemontana.astrological_sign.must_be_nil }
        end
      end
    end
  end
end
