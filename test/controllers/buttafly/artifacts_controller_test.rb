require 'test_helper'

module Buttafly
  class ArtifactsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    Given(:legend) { buttafly_legends(:review) }
    Given(:originable) { buttafly_spreadsheets(:review) }
    Given(:mapping) { Buttafly::Mapping.create(
      legend: legend, originable: originable) }
    Given { mapping && mapping.import! }

    describe "should destroy artifact" do

      Given(:artifact) { Buttafly::Artifact.where(status: "was_new").first }
      Given { artifact }

      Then { artifact.data.must_equal "blah"}

      Then do
        assert_difference('Artifact.count', -1) do
          delete artifact_url(artifact)
        end
      end

      And { assert_redirected_to artifacts_url }
    end
  end
end
