class RemoveComments < ActiveRecord::Migration

  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.integer :user_id, :article_id
      t.text :body, :body_html
      t.timestamps
    end
    add_index :comments, :user_id
  end
end
