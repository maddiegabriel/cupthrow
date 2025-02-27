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

ActiveRecord::Schema.define(version: 2020_11_14_221459) do

  create_table "games", force: :cascade do |t|
    t.string "goal_description"
    t.string "server_throw"
    t.integer "player_id"
    t.integer "player_score"
    t.integer "server_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "goal_score"
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.integer "points"
    t.integer "gems"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bag_desc"
    t.string "throw_desc"
  end

  create_table "sign_ins", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
