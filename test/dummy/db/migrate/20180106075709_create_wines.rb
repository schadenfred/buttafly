class CreateWines < ActiveRecord::Migration[5.1]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :vintage
      t.integer :winery_id

      t.timestamps
    end
  end
end
