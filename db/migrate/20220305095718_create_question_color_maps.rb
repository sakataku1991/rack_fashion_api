class CreateQuestionColorMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :question_color_maps do |t|

      t.references :color, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
