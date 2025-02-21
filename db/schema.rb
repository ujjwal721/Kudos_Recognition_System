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

ActiveRecord::Schema[8.0].define(version: 2025_02_21_045532) do
  create_table "kudos", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.text "message"
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id"], name: "index_kudos_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", null: false
    t.string "password_digest"
    t.integer "leaderboard_score", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["leaderboard_score"], name: "index_users_on_leaderboard_score"
  end

  add_foreign_key "kudos", "users", column: "receiver_id"
  add_foreign_key "kudos", "users", column: "sender_id"
end
