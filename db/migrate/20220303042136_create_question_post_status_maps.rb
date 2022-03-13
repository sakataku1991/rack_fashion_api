class CreateQuestionPostStatusMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :question_post_status_maps do |t|
      t.references :post_status, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
