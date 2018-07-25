# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180716093931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "role",                   default: 0
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "conditions", force: :cascade do |t|
    t.string   "key"
    t.string   "title"
    t.string   "inline_desc"
    t.string   "desc"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "conditions_selfie_forms", force: :cascade do |t|
    t.integer  "selfie_form_id"
    t.integer  "condition_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["condition_id"], name: "index_conditions_selfie_forms_on_condition_id", using: :btree
    t.index ["selfie_form_id"], name: "index_conditions_selfie_forms_on_selfie_form_id", using: :btree
  end

  create_table "consultations", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "category"
    t.string   "user_status"
    t.integer  "amount",      limit: 2
    t.integer  "coupon_id"
    t.string   "pay_status"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "doctor_id"
    t.index ["coupon_id"], name: "index_consultations_on_coupon_id", using: :btree
    t.index ["doctor_id"], name: "index_consultations_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_consultations_on_patient_id", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.text     "coupon_code",               null: false
    t.integer  "discount_amount", limit: 2, null: false
    t.string   "status",                    null: false
    t.datetime "expires_on"
    t.integer  "count",                     null: false
    t.integer  "max_count",                 null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string   "category"
    t.string   "sub_category"
    t.jsonb    "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "email",                        default: "",    null: false
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name",                                   null: false
    t.string   "last_name"
    t.string   "mobile"
    t.string   "location",                                     null: false
    t.string   "avatar",                                       null: false
    t.string   "qualification",                                null: false
    t.text     "desc"
    t.integer  "consultations_count",          default: 0,     null: false
    t.integer  "selfies_count",                default: 0,     null: false
    t.integer  "experience",                   default: 0,     null: false
    t.boolean  "available_for_consultation",   default: false
    t.boolean  "available_for_selfie_checkup", default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "code"
    t.index ["email"], name: "index_doctors_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true, using: :btree
  end

  create_table "my_consultations", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "mobile",                   null: false
    t.string   "email"
    t.integer  "age"
    t.string   "sex"
    t.string   "city"
    t.string   "category"
    t.string   "user_status"
    t.string   "pay_status"
    t.integer  "coupon_id"
    t.integer  "amount",         limit: 2
    t.string   "txnid"
    t.string   "mode"
    t.string   "pg_type"
    t.string   "bank_ref_num"
    t.string   "local_referrer"
    t.string   "utm_campaign"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["coupon_id"], name: "index_my_consultations_on_coupon_id", using: :btree
  end

  create_table "patient_referrals", force: :cascade do |t|
    t.integer  "referrer_id"
    t.integer  "referee_id"
    t.integer  "consultation_id"
    t.boolean  "paid",                      default: false
    t.boolean  "refunded",                  default: false
    t.integer  "referrer_amount", limit: 2
    t.integer  "referee_amount",  limit: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["consultation_id"], name: "index_patient_referrals_on_consultation_id", using: :btree
    t.index ["referee_id"], name: "index_patient_referrals_on_referee_id", using: :btree
    t.index ["referrer_id"], name: "index_patient_referrals_on_referrer_id", using: :btree
  end

  create_table "patient_sources", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "local_referrer"
    t.string   "utm_campaign"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "consultation_id"
    t.index ["consultation_id"], name: "index_patient_sources_on_consultation_id", using: :btree
    t.index ["patient_id"], name: "index_patient_sources_on_patient_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.string   "mobile",     null: false
    t.string   "pay_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "referrer"
    t.integer  "age"
    t.string   "sex"
    t.string   "city"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "txnid",           null: false
    t.string   "status",          null: false
    t.string   "desc",            null: false
    t.string   "amount",          null: false
    t.string   "add_charge"
    t.string   "mihpayid"
    t.string   "mode",            null: false
    t.string   "pg_type"
    t.string   "bank_ref_num"
    t.integer  "patient_id"
    t.integer  "consultation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["consultation_id"], name: "index_payments_on_consultation_id", using: :btree
    t.index ["patient_id"], name: "index_payments_on_patient_id", using: :btree
  end

  create_table "questionnaire_logics", force: :cascade do |t|
    t.string   "name"
    t.integer  "questionnaire_id"
    t.boolean  "is_mandatory"
    t.boolean  "requires_check"
    t.jsonb    "jump_logic"
    t.jsonb    "static_params"
    t.jsonb    "dynamic_params"
    t.integer  "go_to",                         array: true
    t.boolean  "save_checkpoint"
    t.integer  "entry_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["questionnaire_id"], name: "index_questionnaire_logics_on_questionnaire_id", using: :btree
  end

  create_table "questionnaire_response_images", force: :cascade do |t|
    t.integer  "questionnaire_response_id"
    t.string   "image"
    t.string   "image_type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["questionnaire_response_id"], name: "index_by_questionnaire_response", using: :btree
  end

  create_table "questionnaire_responses", force: :cascade do |t|
    t.integer  "consultation_id"
    t.jsonb    "responses",        default: {}
    t.datetime "form_finished_at"
    t.string   "category"
    t.string   "status"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["consultation_id"], name: "index_questionnaire_responses_on_consultation_id", using: :btree
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string   "question"
    t.string   "desc",       default: ""
    t.jsonb    "answers"
    t.string   "field_type"
    t.string   "variables",                            array: true
    t.string   "image"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "selfie_forms", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "content_type"
    t.string   "desc",           limit: 140
    t.string   "status"
    t.string   "diagnosis_link"
    t.integer  "doctor_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["doctor_id"], name: "index_selfie_forms_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_selfie_forms_on_patient_id", using: :btree
  end

  create_table "selfie_images", force: :cascade do |t|
    t.integer  "selfie_form_id"
    t.string   "image"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["selfie_form_id"], name: "index_selfie_images_on_selfie_form_id", using: :btree
  end

  create_table "simple_quiz_responses", force: :cascade do |t|
    t.integer  "patient_id"
    t.jsonb    "responses"
    t.integer  "simple_quiz_id"
    t.integer  "diagnosis_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["diagnosis_id"], name: "index_simple_quiz_responses_on_diagnosis_id", using: :btree
    t.index ["patient_id"], name: "index_simple_quiz_responses_on_patient_id", using: :btree
    t.index ["simple_quiz_id"], name: "index_simple_quiz_responses_on_simple_quiz_id", using: :btree
  end

  create_table "simple_quizzes", force: :cascade do |t|
    t.string   "content_type"
    t.jsonb    "questions"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sms_services", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "consultation_id"
    t.string   "sms_type"
    t.string   "sms_id"
    t.string   "status"
    t.integer  "detailed_status_code"
    t.datetime "date_sent"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["consultation_id"], name: "index_sms_services_on_consultation_id", using: :btree
    t.index ["patient_id"], name: "index_sms_services_on_patient_id", using: :btree
  end

  add_foreign_key "conditions_selfie_forms", "conditions"
  add_foreign_key "conditions_selfie_forms", "selfie_forms"
  add_foreign_key "consultations", "coupons"
  add_foreign_key "consultations", "doctors"
  add_foreign_key "my_consultations", "coupons"
  add_foreign_key "patient_sources", "consultations"
  add_foreign_key "payments", "consultations"
  add_foreign_key "selfie_forms", "doctors"
  add_foreign_key "simple_quiz_responses", "diagnoses"
  add_foreign_key "simple_quiz_responses", "simple_quizzes"
  add_foreign_key "sms_services", "consultations"
  add_foreign_key "sms_services", "patients"
end
