class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :astrological_sign
      t.integer

      t.timestamps
    end
  end
end
