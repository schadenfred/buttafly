class AddStatusColumnToButtaflyArtifacts < ActiveRecord::Migration[5.1]
  def change
    add_column :buttafly_artifacts, :status, :integer
  end
end
