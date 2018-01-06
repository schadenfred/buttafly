class CreateButtaflySpreadsheets < ActiveRecord::Migration[5.1]
  def change
    create_table :buttafly_spreadsheets do |t|
      t.string :name
      t.string :flat_file
      t.string :aasm_state
      t.integer :uploader_id
      t.datetime :imported_at
      t.datetimesour_row_count :processed_at
      t.integer :mtime

      t.timestamps

      add_index :buttafly_spreadsheets, :uploader_id
      add_index :buttafly_spreadsheets, :name
      add_index :buttafly_spreadsheets, :imported_at
      add_index :buttafly_spreadsheets, :processed_at
      add_index :buttafly_spreadsheets, :aasm_state
    end
  end
end
