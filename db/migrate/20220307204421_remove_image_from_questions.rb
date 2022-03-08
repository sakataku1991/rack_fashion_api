class RemoveImageFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :image, :string
  end
end
