class CreateUserSexMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :user_sex_maps do |t|
      t.references :sex, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
