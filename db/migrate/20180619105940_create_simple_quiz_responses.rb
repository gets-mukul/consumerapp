class CreateSimpleQuizResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :simple_quiz_responses do |t|
      t.belongs_to :patient, index: true
      t.column :responses, :jsonb
      t.references :simple_quiz, foreign_key: true, index: true
      t.references :diagnosis, foreign_key: true, index: true
      t.timestamps
    end
  end
end
