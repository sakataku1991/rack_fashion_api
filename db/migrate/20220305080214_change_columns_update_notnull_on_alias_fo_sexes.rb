class ChangeColumnsUpdateNotnullOnAliasFoSexes < ActiveRecord::Migration[6.1]
  def change
    change_column :sexes, :alias, :string, null: false
  end
end
