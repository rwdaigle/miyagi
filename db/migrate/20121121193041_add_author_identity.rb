class AddAuthorIdentity < ActiveRecord::Migration

  def up
    change_table :users do |t|
      t.string :first_name, :last_name, :twitter_username, :gh_username, :site_url
      t.text :profile, :profile_html
    end
  end

  def down
    remove_column :users, :first_name, :last_name, :twitter_username, :gh_username, :site_url
    remove_column :users, :profile, :profile_html
  end
end
