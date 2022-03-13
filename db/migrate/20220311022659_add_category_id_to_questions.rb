class AddCategoryIdToQuestions < ActiveRecord::Migration[6.1]
  def change

    add_reference :questions, :category, foreign_key: true

  end
end
