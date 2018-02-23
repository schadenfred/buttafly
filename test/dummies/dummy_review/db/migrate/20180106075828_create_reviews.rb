class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :content
      t.integer :reviewer_id
      t.string :wine_id

      t.timestamps
    end
  end
end
