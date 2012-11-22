class AddUserGuid < ActiveRecord::Migration

  def up
    change_table :users do |t|
      t.string :uuid
    end
    add_index :users, :uuid
  end

  def down
    remove_column :users, :uuid
  end
end
