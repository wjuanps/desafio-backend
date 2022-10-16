# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_16_011410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deputies", force: :cascade do |t|
    t.integer "deputy_identifier", null: false
    t.string "taxpayer", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deputy_quota", force: :cascade do |t|
    t.integer "sub_quota_number", null: false
    t.string "description"
    t.integer "sub_quota_specification_number"
    t.string "description_specification"
    t.bigint "legislature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["legislature_id"], name: "index_deputy_quota_on_legislature_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "document_number", null: false
    t.integer "document_type", null: false
    t.datetime "issue_date"
    t.decimal "document_value", precision: 10, scale: 2
    t.decimal "gross_value", precision: 10, scale: 2
    t.decimal "net_value", precision: 10, scale: 2
    t.integer "year"
    t.integer "month"
    t.integer "installments"
    t.string "passenger_name"
    t.string "leg_trip"
    t.integer "batch"
    t.integer "refund"
    t.integer "restitution"
    t.string "document_url"
    t.integer "requester_id"
    t.bigint "deputy_id", null: false
    t.bigint "provider_id", null: false
    t.bigint "deputy_quota_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_invoices_on_deputy_id"
    t.index ["deputy_quota_id"], name: "index_invoices_on_deputy_quota_id"
    t.index ["provider_id"], name: "index_invoices_on_provider_id"
  end

  create_table "legislatures", force: :cascade do |t|
    t.integer "legislature_number"
    t.integer "legislature_code"
    t.string "parliamentary_card"
    t.string "state"
    t.string "political_party"
    t.bigint "deputy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_legislatures_on_deputy_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "provider_identifier", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deputy_quota", "legislatures"
  add_foreign_key "invoices", "deputies"
  add_foreign_key "invoices", "deputy_quota", column: "deputy_quota_id"
  add_foreign_key "invoices", "providers"
  add_foreign_key "legislatures", "deputies"
end
