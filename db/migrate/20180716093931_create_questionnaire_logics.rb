class CreateQuestionnaireLogics < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaire_logics do |t|
      t.column  :name,                :string
      t.references :questionnaire,    index: true

      t.column  :is_mandatory,        :boolean
      t.column  :requires_check,      :boolean

      t.column  :jump_logic,          :jsonb
      t.column  :static_params,       :jsonb
      t.column  :dynamic_params,      :jsonb
      # t.references :questionnaire, foreign_key: true, column: :static_params, index: true, array: true
      # t.references :questionnaire, foreign_key: true, column: :dynamic_params, index: true, array: true

      t.column  :go_to,               :integer, array: true
      # t.column  :dependent_questions, :integer, array:true

      # t.references :questionnaire,    foreign_key: true, column: :dependent_questions, index: true, array: true
      t.column  :save_checkpoint,     :boolean
      t.column  :entry_type,                :integer

      t.timestamps
    end
  end
end
