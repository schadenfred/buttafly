require 'test_helper'

module Buttafly
  # describe Artifact do
  class ArtifactTest < ActiveSupport::TestCase

    subject { Buttafly::Artifact}
    Given(:artifact) { buttafly_artifacts(:one) }

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

    specify "#is_new" do
      artifact.respond_to? :is_new
    end
  end
end
