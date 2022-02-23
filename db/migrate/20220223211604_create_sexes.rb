class CreateSexes < ActiveRecord::Migration[6.1]
  def change
    create_table :sexes do |t|

      t.string :sex, null: false
      t.string :code, null: false

      t.timestamps
    end
  end
end
