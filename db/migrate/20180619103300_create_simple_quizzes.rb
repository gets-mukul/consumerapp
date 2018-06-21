class CreateSimpleQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :simple_quizzes do |t|
      t.column :content_type, :string
      t.column :questions, :jsonb
      t.timestamps
    end
  end
end
