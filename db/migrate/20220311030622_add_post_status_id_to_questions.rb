class AddPostStatusIdToQuestions < ActiveRecord::Migration[6.1]
  def change

    add_reference :questions, :post_status, foreign_key: true

  end
end
