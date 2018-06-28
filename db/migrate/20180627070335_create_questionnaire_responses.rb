class CreateQuestionnaireResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_responses do |t|
      t.belongs_to :patient,        index: true
      t.jsonb :responses,           default: {}
      t.timestamp :form_finished_at
      t.string :category
      t.string :status
      t.timestamps
    end
  end
end
