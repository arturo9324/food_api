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

ActiveRecord::Schema.define(version: 20160831210332) do

  create_table "has_nutrients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "product_id"
    t.integer  "nutrient_id"
    t.float    "cantidad",    limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["nutrient_id"], name: "index_has_nutrients_on_nutrient_id", using: :btree
    t.index ["product_id"], name: "index_has_nutrients_on_product_id", using: :btree
  end

  create_table "measures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "nombre"
    t.string   "abrebiacion"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "nutrients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "measure_id"
    t.index ["measure_id"], name: "index_nutrients_on_measure_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "nombre"
    t.float    "cantidad",           limit: 24
    t.float    "calorias",           limit: 24
    t.string   "codigo"
    t.boolean  "porciones"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_foreign_key "has_nutrients", "nutrients"
  add_foreign_key "has_nutrients", "products"
  add_foreign_key "nutrients", "measures"
end
