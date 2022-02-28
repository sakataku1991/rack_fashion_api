class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile, :text, null: false, default: 'よろしくお願いします。'
    add_column :users, :instagram, :string
    add_column :users, :twitter, :string
    add_column :users, :homepage, :text
  end
end
