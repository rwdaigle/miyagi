class AddArticleSlugs < ActiveRecord::Migration

  def up
    change_table :articles do |t|
      t.string :slug
    end
  end

  def down
    remove_column :articles, :slug
  end
end
