class AddComments < ActiveRecord::Migration

  def up
    create_table :comments do |t|
      t.integer :user_id, :article_id
      t.text :body, :body_html
      t.timestamps
    end
    add_index :comments, :user_id
  end

  def down
    drop_table :comments
  end
end
