class RemoveColumnIsNewFromButtaflyArtifacts < ActiveRecord::Migration[5.1]
  def change
    remove_column :buttafly_artifacts, :is_new
  end
end
