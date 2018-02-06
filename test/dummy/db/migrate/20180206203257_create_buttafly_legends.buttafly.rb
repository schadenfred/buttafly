# This migration comes from buttafly (originally 20180106034801)
class CreateButtaflyLegends < ActiveRecord::Migration[5.1]
  def change
    create_table :buttafly_legends do |t|
      t.text :data
      t.string :targetable_model

      t.timestamps
    end
  end
end
