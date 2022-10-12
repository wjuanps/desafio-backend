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

ActiveRecord::Schema.define(version: 2022_10_11_235128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deputies", force: :cascade do |t|
    t.integer "deputy_identifier", null: false
    t.string "taxpayer", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "document_number", null: false
    t.integer "document_type", null: false
    t.datetime "issue_date"
    t.integer "document_value"
    t.integer "gross_value"
    t.integer "net_value"
    t.integer "year", null: false
    t.integer "month", null: false
    t.integer "installments"
    t.string "passenger_name"
    t.string "leg_trip"
    t.integer "batch"
    t.integer "refund"
    t.integer "restitution"
    t.string "document_url"
    t.integer "requester_id", null: false
    t.bigint "quota_id", null: false
    t.bigint "provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id"], name: "index_invoices_on_provider_id"
    t.index ["quota_id"], name: "index_invoices_on_quota_id"
  end

  create_table "legislatures", force: :cascade do |t|
    t.integer "legislature_number"
    t.integer "legislature_code", null: false
    t.string "parliamentary_card", null: false
    t.string "state", null: false
    t.string "political_party", null: false
    t.bigint "deputy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_legislatures_on_deputy_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "provider_identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quota", force: :cascade do |t|
    t.integer "sub_quota_number", null: false
    t.string "description"
    t.integer "sub_quota_esoecification_number"
    t.string "description_especification"
    t.bigint "legislature_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["legislature_id"], name: "index_quota_on_legislature_id"
  end

  add_foreign_key "invoices", "providers"
  add_foreign_key "invoices", "quota", column: "quota_id"
  add_foreign_key "legislatures", "deputies"
  add_foreign_key "quota", "legislatures"
end
