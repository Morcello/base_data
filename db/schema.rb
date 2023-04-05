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

ActiveRecord::Schema[7.0].define(version: 2023_04_05_195202) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_registries", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.string "password", default: "", null: false
    t.datetime "date_application", null: false
    t.datetime "date_issue", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "register_of_owners_id"
    t.index ["password"], name: "index_access_registries_on_password", unique: true
    t.index ["register_of_owners_id"], name: "index_access_registries_on_register_of_owners_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "register_of_documents", force: :cascade do |t|
    t.string "city", default: "", null: false
    t.string "street", default: "", null: false
    t.string "house_no", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_register_of_documents_on_city"
    t.index ["house_no"], name: "index_register_of_documents_on_house_no"
    t.index ["street"], name: "index_register_of_documents_on_street"
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

  create_table "service_cancellations", force: :cascade do |t|
    t.string "middle_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.datetime "date_rejection", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "register_of_owners_id", null: false
    t.index ["first_name"], name: "index_service_cancellations_on_first_name", unique: true
    t.index ["last_name"], name: "index_service_cancellations_on_last_name", unique: true
    t.index ["middle_name"], name: "index_service_cancellations_on_middle_name", unique: true
    t.index ["register_of_owners_id"], name: "index_service_cancellations_on_register_of_owners_id"
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

  add_foreign_key "access_registries", "register_of_owners", column: "register_of_owners_id"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "service_cancellations", "register_of_owners", column: "register_of_owners_id"
end
