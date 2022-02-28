class RenameSexColumnToSexes < ActiveRecord::Migration[6.1]
  def change
    rename_column :sexes, :sex, :gender
  end
end
