class AddIndexQuestionsUserId < ActiveRecord::Migration[6.1]
  def change
    add_index :questions, [:user_id, :created_at], unique: true
  end
end
