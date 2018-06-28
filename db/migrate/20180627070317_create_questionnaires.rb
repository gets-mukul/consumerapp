class CreateQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    create_table  :questionnaires do |t|
      t.string    :question
      t.string    :desc,              default: ""
      t.jsonb     :answers
      t.string    :field_type
      t.timestamps
    end
  end
end
