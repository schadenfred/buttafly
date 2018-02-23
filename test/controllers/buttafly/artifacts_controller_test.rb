require 'test_helper'

module Buttafly
  class ArtifactsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    Given(:mapping) { buttafly_mappings(:review_review) }
    Given { mapping.import! }
    Given(:artifact) { Artifact.last }

    describe "#destroy" do

      Given(:request) { delete artifact_url(artifact) }

      Then { assert_difference('Artifact.count', -1) { request } }
    end

    describe "#revert" do

      Given(:record_class) { artifact.data.keys.second.classify }
      Given(:request) { patch revert_artifact_url(artifact) }
      Given { artifact }

      Then { assert_difference('Artifact.count', -1) { request } }
    end
  end
end
