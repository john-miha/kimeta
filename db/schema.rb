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

ActiveRecord::Schema.define(version: 2022_05_12_092217) do

  create_table "charts", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "summarycomment"
    t.integer "mybest"
  end

  create_table "evaluations", charset: "utf8mb4", force: :cascade do |t|
    t.integer "score"
    t.string "comment"
    t.bigint "chart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chart_id"], name: "index_evaluations_on_chart_id"
  end

  create_table "items", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "evaluation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evaluation_id"], name: "index_items_on_evaluation_id"
  end

  create_table "viewpoints", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "evaluation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evaluation_id"], name: "index_viewpoints_on_evaluation_id"
  end

  add_foreign_key "evaluations", "charts"
  add_foreign_key "items", "evaluations"
  add_foreign_key "viewpoints", "evaluations"
end
