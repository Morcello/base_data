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

ActiveRecord::Schema[7.0].define(version: 2023_01_29_151202) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_registrys", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.string "password", default: "", null: false
    t.datetime "date_application", null: false
    t.datetime "date_issue", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "register_of_owners_id", null: false
    t.index ["password"], name: "index_access_registrys_on_password", unique: true
    t.index ["register_of_owners_id"], name: "index_access_registrys_on_register_of_owners_id"
  end

  create_table "register_of_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "middle_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "personal_account", default: "", null: false
    t.string "city", default: "", null: false
    t.string "street", default: "", null: false
    t.string "house_no", default: "", null: false
    t.integer "apartment_no", null: false
    t.integer "number_owners", null: false
    t.string "phone", default: "", null: false
    t.datetime "home_activation_date", null: false
    t.datetime "subscriber_blocking_date", null: false
    t.string "contractor", default: "", null: false
    t.string "serial_number", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_account"], name: "index_register_of_owners_on_personal_account", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "role", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access_registrys", "register_of_owners", column: "register_of_owners_id"
end
