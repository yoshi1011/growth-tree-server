# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_24_074447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigned_curriculums", force: :cascade do |t|
    t.bigint "curriculum_id"
    t.bigint "user_id", comment: "カリキュラムを割り当てられた従業員のID"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curriculum_id"], name: "index_assigned_curriculums_on_curriculum_id"
    t.index ["user_id"], name: "index_assigned_curriculums_on_user_id"
  end

  create_table "assigned_missions", force: :cascade do |t|
    t.bigint "set_mission_id"
    t.bigint "user_id", comment: "ミッションを割り当てられた従業員のID"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["set_mission_id"], name: "index_assigned_missions_on_set_mission_id"
    t.index ["user_id"], name: "index_assigned_missions_on_user_id"
  end

  create_table "assigned_tasks", force: :cascade do |t|
    t.bigint "set_task_id"
    t.bigint "user_id", comment: "タスクを割り当てられた従業員のID"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["set_task_id"], name: "index_assigned_tasks_on_set_task_id"
    t.index ["user_id"], name: "index_assigned_tasks_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "source_type"
    t.bigint "source_id", comment: "Task, Commentなど複数で利用"
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["source_type", "source_id"], name: "index_attachments_on_source"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "assigned_task_id"
    t.bigint "user_id", comment: "コメントをするユーザーのID"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assigned_task_id"], name: "index_comments_on_assigned_task_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.string "prefecture"
    t.string "city"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "curriculums", force: :cascade do |t|
    t.bigint "company_id", comment: "カリキュラムを登録している企業"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_curriculums_on_company_id"
  end

  create_table "missions", force: :cascade do |t|
    t.bigint "company_id", comment: "ミッションを登録している企業"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_missions_on_company_id"
  end

  create_table "owned_skills", force: :cascade do |t|
    t.bigint "user_id", comment: "スキルを所有しているユーザーのID"
    t.bigint "skill_id"
    t.integer "point", comment: "スキルの習得率 0〜100点"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["skill_id"], name: "index_owned_skills_on_skill_id"
    t.index ["user_id"], name: "index_owned_skills_on_user_id"
  end

  create_table "set_missions", force: :cascade do |t|
    t.bigint "curriculum_id"
    t.bigint "mission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["curriculum_id"], name: "index_set_missions_on_curriculum_id"
    t.index ["mission_id"], name: "index_set_missions_on_mission_id"
  end

  create_table "set_tasks", force: :cascade do |t|
    t.bigint "mission_id"
    t.bigint "task_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mission_id"], name: "index_set_tasks_on_mission_id"
    t.index ["task_id"], name: "index_set_tasks_on_task_id"
  end

  create_table "skill_points", force: :cascade do |t|
    t.bigint "mission_id", comment: "スキルポイントを獲得できるミッションのID"
    t.bigint "skill_id"
    t.integer "point", comment: "そのミッションを通じて獲得できるスキルのポイント"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mission_id"], name: "index_skill_points_on_mission_id"
    t.index ["skill_id"], name: "index_skill_points_on_skill_id"
  end

  create_table "skills", force: :cascade do |t|
    t.bigint "company_id", comment: "スキルを登録している企業"
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_skills_on_company_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "company_id", comment: "タスクを登録している企業"
    t.string "name"
    t.text "description"
    t.boolean "must_be_submitted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_tasks_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "image_url"
    t.string "email"
    t.integer "role", comment: "Manager, Employeeなどを区別するための項目"
    t.date "joined_date", comment: "入社日"
    t.json "tokens"
    t.bigint "company_id"
    t.bigint "manager_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "assigned_curriculums", "curriculums"
  add_foreign_key "assigned_curriculums", "users"
  add_foreign_key "assigned_missions", "set_missions"
  add_foreign_key "assigned_missions", "users"
  add_foreign_key "assigned_tasks", "set_tasks"
  add_foreign_key "assigned_tasks", "users"
  add_foreign_key "comments", "assigned_tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "curriculums", "companies"
  add_foreign_key "missions", "companies"
  add_foreign_key "owned_skills", "skills"
  add_foreign_key "owned_skills", "users"
  add_foreign_key "set_missions", "curriculums"
  add_foreign_key "set_missions", "missions"
  add_foreign_key "set_tasks", "missions"
  add_foreign_key "set_tasks", "tasks"
  add_foreign_key "skill_points", "missions"
  add_foreign_key "skill_points", "skills"
  add_foreign_key "skills", "companies"
  add_foreign_key "tasks", "companies"
  add_foreign_key "users", "users", column: "manager_id"
end
