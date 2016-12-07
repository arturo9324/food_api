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

ActiveRecord::Schema.define(version: 20161206221819) do

  create_table "app_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "has_nutrients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "product_id"
    t.integer  "nutrient_id"
    t.float    "cantidad",    limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["nutrient_id"], name: "index_has_nutrients_on_nutrient_id", using: :btree
    t.index ["product_id"], name: "index_has_nutrients_on_product_id", using: :btree
  end

  create_table "info_app_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "app_user_id"
    t.date     "fecha_nacimiento"
    t.float    "peso",             limit: 24
    t.float    "estatura",         limit: 24
    t.boolean  "sexo",                        default: true
    t.float    "max_calorias",     limit: 24
    t.float    "min_calorias",     limit: 24
    t.boolean  "embarazo",                    default: false
    t.boolean  "lactancia",                   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["app_user_id"], name: "index_info_app_users_on_app_user_id", using: :btree
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

  create_table "portions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "product_id"
    t.integer  "measure_id"
    t.float    "porcion",      limit: 24
    t.float    "cantidad",     limit: 24
    t.string   "equivalencia"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["measure_id"], name: "index_portions_on_measure_id", using: :btree
    t.index ["product_id"], name: "index_portions_on_product_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "nombre"
    t.float    "cantidad",           limit: 24
    t.integer  "calorias"
    t.string   "codigo"
    t.boolean  "porciones",                     default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.integer  "measure_id"
    t.index ["measure_id"], name: "index_products_on_measure_id", using: :btree
    t.index ["user_id"], name: "index_products_on_user_id", using: :btree
  end

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "expires_at"
    t.integer  "app_user_id"
    t.string   "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["app_user_id"], name: "index_tokens_on_app_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "companies", "users"
  add_foreign_key "has_nutrients", "nutrients"
  add_foreign_key "has_nutrients", "products"
  add_foreign_key "info_app_users", "app_users"
  add_foreign_key "nutrients", "measures"
  add_foreign_key "portions", "measures"
  add_foreign_key "portions", "products"
  add_foreign_key "products", "measures"
  add_foreign_key "products", "users"
  add_foreign_key "tokens", "app_users"
end
