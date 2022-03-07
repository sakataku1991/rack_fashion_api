class CreateQuestionHashtagMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :question_hashtag_maps do |t|

      t.references :hashtag, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
    # 一つの質問に同じハッシュタグを何個も何個も付けられないように制限する
    add_index :question_hashtag_maps, [:hashtag_id, :question_id], unique: true
  end
end
