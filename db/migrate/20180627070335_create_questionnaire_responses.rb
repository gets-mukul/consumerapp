class CreateQuestionnaireResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_responses do |t|
      t.belongs_to :consultation,        index: true
      t.jsonb :responses,           default: {}
      t.timestamp :form_finished_at
      t.string :category
      t.string :status
      t.timestamps
    end

    create_table :questionnaire_response_images do |t|
      t.belongs_to :questionnaire_response, index: {:name => "index_by_questionnaire_response"}
      t.string :image
      t.string :image_type
      t.timestamps
    end
  end
end
