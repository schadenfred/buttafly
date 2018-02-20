require 'test_helper'

module Buttafly
  class ArtifactTest < ActiveSupport::TestCase

    subject { Buttafly::Artifact}

    describe "db" do

      specify "columns" do
        must_have_column(:data, :text)
        must_have_column(:is_new, :boolean)
      end
    end

    describe "associations" do

      specify "belongs_to" do

        must_belong_to(:mapping)
      end
    end

    describe "#revert_record" do

      Given { User.create!(name: "keena turner") }
      Given { User.create!(name: "madonna", age: 69, astrological_sign: "Aquarius") }

      Given(:artifact_count) { "Buttafly::Artifact.count" }
      Given(:mapping) { buttafly_mappings(:review_review) }
      Given { mapping.transmogrify }

      describe "from new deletes the record and the artifact" do

        Given(:artifact) { Buttafly::Artifact.where(status: "was_new").last }

        Then { assert_difference(["Review.count", artifact_count], -1) { artifact.revert_record } }
      end

      describe "from new deletes the record and the artifact" do
Given { skip }
        Given(:artifact) { Buttafly::Artifact.where(status: "was_updated").last }
        Then { byebug }
        # Then { assert_difference([artifact_count], -1) { artifact.revert_record } }
      end
    end
  end
end
