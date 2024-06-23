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

ActiveRecord::Schema[7.1].define(version: 2024_06_20_023053) do
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

  create_table "deposits", force: :cascade do |t|
    t.string "symbol"
    t.integer "user_id"
    t.decimal "amount"
    t.string "gateway"
    t.string "gateway_id"
    t.integer "confirmations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gateway_id"], name: "index_deposits_on_gateway_id"
    t.index ["symbol"], name: "index_deposits_on_symbol"
    t.index ["user_id"], name: "index_deposits_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "provider"
    t.string "provider_id"
    t.json "provider_info"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider"], name: "index_identities_on_provider"
    t.index ["provider_id"], name: "index_identities_on_provider_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "sell_symbol"
    t.decimal "sell_amount"
    t.decimal "remaining_sell_amount"
    t.string "buy_symbol"
    t.decimal "buy_amount"
    t.decimal "remaining_buy_amount"
    t.integer "user_id"
    t.boolean "completed", default: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_amount"], name: "index_orders_on_buy_amount"
    t.index ["price"], name: "index_orders_on_price"
    t.index ["sell_amount"], name: "index_orders_on_sell_amount"
    t.index ["sell_symbol", "buy_symbol"], name: "index_orders_on_sell_symbol_and_buy_symbol"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.string "stage"
    t.string "repository_url"
    t.string "explorer_url"
    t.integer "followers_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_projects_on_symbol"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "email_verified_at"
    t.datetime "last_login_at"
    t.string "last_login_ip"
    t.string "last_login_user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio"
    t.index ["email"], name: "index_users_on_email"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
