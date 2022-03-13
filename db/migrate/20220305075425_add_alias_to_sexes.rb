class AddAliasToSexes < ActiveRecord::Migration[6.1]
  def change
    add_column :sexes, :alias, :string
  end
end
