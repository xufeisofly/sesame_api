# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_06_113917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cap"
    t.string "py_cap"
    t.string "pinyin"
    t.index ["cap"], name: "index_cities_on_cap"
    t.index ["code"], name: "index_cities_on_code"
    t.index ["name"], name: "index_cities_on_name"
    t.index ["pinyin"], name: "index_cities_on_pinyin"
    t.index ["py_cap"], name: "index_cities_on_py_cap"
  end

  create_table "city_tag_relations", force: :cascade do |t|
    t.integer "city_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "tag_id"], name: "index_city_tag_relations_on_city_id_and_tag_id", unique: true
    t.index ["city_id"], name: "index_city_tag_relations_on_city_id"
    t.index ["tag_id"], name: "index_city_tag_relations_on_tag_id"
  end

  create_table "pois", force: :cascade do |t|
    t.string "cn_name"
    t.string "artwork"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_pois_on_city_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "category", comment: "标签类型"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_tags_on_category"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "start_id"
    t.integer "end_id"
    t.string "train_no"
    t.string "start_time"
    t.string "end_time"
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_id"], name: "index_tickets_on_end_id"
    t.index ["start_id", "end_id", "train_no"], name: "index_tickets_on_start_id_and_end_id_and_train_no", unique: true
    t.index ["start_id"], name: "index_tickets_on_start_id"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "start_city_id", comment: "出发城市 id"
    t.integer "end_city_id", comment: "到达城市 id"
    t.integer "duration_min", comment: "花费时间，单位 min"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["duration_min"], name: "index_trips_on_duration_min"
    t.index ["start_city_id", "end_city_id"], name: "index_trips_on_start_city_id_and_end_city_id", unique: true
  end

end
