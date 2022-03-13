class RenameGenderColumnToSexes < ActiveRecord::Migration[6.1]
  def change
    rename_column :sexes, :gender, :name
  end
end
