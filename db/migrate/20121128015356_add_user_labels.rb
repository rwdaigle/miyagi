class AddUserLabels < ActiveRecord::Migration

  def up
    change_table :users do |t|
      t.string :label
    end
  end

  def down
    remove_column :users, :label
  end
end
