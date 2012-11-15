class AddContentTypes < ActiveRecord::Migration

  def up

    execute "CREATE EXTENSION hstore"

    create_table :content do |t|

      # STI
      t.string :type, :null => false

      # article
      t.integer :author_id
      t.string :title, :image_url
      t.text :summary, :body
      t.timestamp :published_at

      # referenced content
      t.integer :contributor_id
      t.string :target_url

      # variable info
      t.hstore :details
      
      t.timestamps
    end

    add_index :content, :type
    add_index :content, :published_at
  end

  def down
    drop_table :content
    execute "DROP EXTENSION hstore"
  end
end
