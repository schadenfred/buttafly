class CreateExcelSheets < ActiveRecord::Migration[5.1]
  def change
    create_table :excel_sheets do |t|
      t.string :name
      t.string :flat_file
      t.string :aasm_state

      t.timestamps
    end
  end
end
