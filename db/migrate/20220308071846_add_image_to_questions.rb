class AddImageToQuestions < ActiveRecord::Migration[6.1]
  def change

    add_column :questions, :image, :string

  end
end
