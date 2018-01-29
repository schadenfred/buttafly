class CreateBlacklisteds < ActiveRecord::Migration[5.1]
  def change
    create_table :blacklisteds do |t|

      t.timestamps
    end
  end
end
