class AddArticles < ActiveRecord::Migration

  def up

    create_table :articles do |t|
      t.integer :author_id
      t.string :title, :image_url
      t.text :summary, :body
      t.timestamp :published_at      
      t.timestamps
    end

    add_index :articles, :published_at
  end

  def down
    drop_table :articles
  end
end
