class CreateQuestionCategoryMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :question_category_maps do |t|
      t.references :category, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
