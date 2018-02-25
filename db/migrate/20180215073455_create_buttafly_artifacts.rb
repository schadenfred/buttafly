class CreateButtaflyArtifacts < ActiveRecord::Migration[5.1]
  def change
    create_table :buttafly_artifacts do |t|
      t.belongs_to :mapping, foreign_key: true
      t.text :data
      t.integer :status

      t.timestamps
    end
  end
end
