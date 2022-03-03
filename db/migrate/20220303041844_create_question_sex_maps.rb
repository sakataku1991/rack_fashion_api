class CreateQuestionSexMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :question_sex_maps do |t|
      t.references :sex, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
