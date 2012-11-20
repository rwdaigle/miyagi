class AddArticleProcessing < ActiveRecord::Migration

  def up

    change_table :articles do |t|
      t.text :body_html
    end

    create_table :links do |t|
      t.integer :article_id
      t.string :type, :url
    end

    add_index :links, :article_id
  end

  def down
    drop_table :links
    remove_column :articles, :body_html
  end
end
