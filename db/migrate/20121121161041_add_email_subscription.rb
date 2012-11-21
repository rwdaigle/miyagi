class AddEmailSubscription < ActiveRecord::Migration

  def up
    change_table :users do |t|
      t.string :email
      t.boolean :subscribed, :default => false
    end
    add_index :users, :subscribed
  end

  def down
    remove_column :users, :email, :subscribed
  end
end
