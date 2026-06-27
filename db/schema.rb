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

ActiveRecord::Schema[8.1].define(version: 2026_06_27_024005) do
  create_table "accounts", force: :cascade do |t|
    t.integer "asset_id"
    t.decimal "balance", precision: 36, scale: 18, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "buy_amount", precision: 36, scale: 18, default: "0.0", null: false
    t.string "buy_asset_id", default: "btc", null: false
    t.datetime "cancelled_at"
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.decimal "funded_amount", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "price", precision: 36, scale: 18
    t.decimal "remaining_sell_amount", precision: 36, scale: 18, null: false
    t.decimal "sell_amount", precision: 36, scale: 18, null: false
    t.string "sell_asset_id", default: "usd", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "cancelled_at"], name: "index_orders_on_account_id_and_cancelled_at"
    t.index ["account_id", "completed"], name: "index_orders_on_account_id_and_completed"
    t.index ["account_id"], name: "index_orders_on_account_id"
    t.index ["completed", "cancelled_at"], name: "index_orders_on_completed_and_cancelled_at"
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["price"], name: "index_orders_on_price"
    t.index ["sell_asset_id", "buy_asset_id"], name: "index_orders_on_sell_asset_id_and_buy_asset_id"
  end
end
