class AddColorIdToQuestions < ActiveRecord::Migration[6.1]
  def change

    add_reference :questions, :color, foreign_key: true

  end
end
