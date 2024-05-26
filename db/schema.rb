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

ActiveRecord::Schema[7.1].define(version: 2024_05_24_011323) do
  create_table "draft_picks", force: :cascade do |t|
    t.integer "round"
    t.integer "overall"
    t.integer "year"
    t.string "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["overall", "year"], name: "index_draft_picks_on_overall_and_year", unique: true
    t.index ["team"], name: "index_draft_picks_on_team"
  end

  create_table "picks_by_team_and_seasons", force: :cascade do |t|
    t.string "team"
    t.text "picks"
    t.integer "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season", "team"], name: "index_picks_by_team_and_seasons_on_season_and_team", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "shortname", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shortname"], name: "index_teams_on_shortname", unique: true
  end

  create_table "trades", force: :cascade do |t|
    t.text "team_a_picks"
    t.text "team_b_picks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "team_a"
    t.string "team_b"
  end

  create_table "value_model_picks", force: :cascade do |t|
    t.integer "value_model_id", null: false
    t.integer "pick"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pick", "value_model_id"], name: "index_value_model_picks_on_pick_and_value_model_id", unique: true
    t.index ["value_model_id"], name: "index_value_model_picks_on_value_model_id"
  end

  create_table "value_models", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_value_models_on_name", unique: true
  end

  add_foreign_key "value_model_picks", "value_models"
end
