require "test_helper"

feature "CanRevertImport" do

  scenario "for for all artifacts in mapping" do
    mapping = buttafly_mappings(:review_review)
    mapping.import!
    visit buttafly.mapping_path(mapping)
    click_button(id: "revertMapping-#{mapping.id}")
    page.has_content?("Successfully reverted").must_equal true
  end

  scenario "for just one artifact" do
    mapping = buttafly_mappings(:review_review)
    mapping.import!
    artifact = mapping.artifacts.first
    visit buttafly.mapping_path(mapping)
    click_button(id: "revertArtifact-#{artifact.id}")
    page.has_content?("Artifact was reverted").must_equal true
  end
end
