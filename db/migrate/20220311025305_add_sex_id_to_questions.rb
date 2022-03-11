class AddSexIdToQuestions < ActiveRecord::Migration[6.1]
  def change

    add_reference :questions, :sex, foreign_key: true

  end
end
