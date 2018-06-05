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

ActiveRecord::Schema.define(version: 20170811194140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "allocations", force: :cascade do |t|
    t.bigint "space_id"
    t.date "from_date"
    t.date "to_date"
    t.integer "allocated_by_id"
    t.date "date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "consumer_type"
    t.bigint "consumer_id"
    t.index ["consumer_type", "consumer_id"], name: "index_allocations_on_consumer_type_and_consumer_id"
    t.index ["from_date"], name: "index_allocations_on_from_date"
    t.index ["space_id"], name: "index_allocations_on_space_id"
    t.index ["to_date"], name: "index_allocations_on_to_date"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.integer "min_level"
    t.integer "max_level"
    t.boolean "allocate_equipment", default: true
    t.boolean "moving_items", default: false
  end

  create_table "equipment_groups", force: :cascade do |t|
    t.string "name"
    t.integer "order", default: 1, null: false
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_equipment_groups_on_parent_id"
  end

  create_table "equipment_items", force: :cascade do |t|
    t.integer "qty"
    t.string "itemable_type"
    t.bigint "itemable_id"
    t.bigint "equipment_model_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_model_id"], name: "index_equipment_items_on_equipment_model_id"
    t.index ["itemable_type", "itemable_id"], name: "index_equipment_items_on_itemable_type_and_itemable_id"
  end

  create_table "equipment_models", force: :cascade do |t|
    t.bigint "equipment_group_id"
    t.string "name"
    t.integer "order", default: 1, null: false
    t.string "photo"
    t.string "supplier"
    t.string "model_ident"
    t.decimal "price"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_group_id"], name: "index_equipment_models_on_equipment_group_id"
  end

  create_table "field_defs", force: :cascade do |t|
    t.string "name"
    t.string "field_type"
    t.boolean "required"
    t.integer "order", default: 1, null: false
    t.bigint "table_def_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_def_id"], name: "index_field_defs_on_table_def_id"
  end

  create_table "floor_images", force: :cascade do |t|
    t.integer "level"
    t.bigint "building_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["building_id"], name: "index_floor_images_on_building_id"
  end

  create_table "floors", force: :cascade do |t|
    t.bigint "building_id"
    t.string "name"
    t.string "corners_coor"
    t.float "gage_area"
    t.string "gage_coor"
    t.string "gage_center_coor"
    t.integer "level"
    t.integer "order", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "drawing"
    t.bigint "wing_id"
    t.string "locator_coor"
    t.index ["building_id"], name: "index_floors_on_building_id"
    t.index ["wing_id"], name: "index_floors_on_wing_id"
  end

  create_table "moving_items", force: :cascade do |t|
    t.bigint "allocation_id"
    t.float "weight"
    t.float "volume"
    t.text "notes"
    t.bigint "destination_id"
    t.bigint "replace_id"
    t.string "description"
    t.integer "qty", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allocation_id"], name: "index_moving_items_on_allocation_id"
    t.index ["destination_id"], name: "index_moving_items_on_destination_id"
    t.index ["replace_id"], name: "index_moving_items_on_replace_id"
  end

  create_table "moving_tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "specialty_id"
    t.integer "responsability"
    t.integer "order", default: 1, null: false
    t.datetime "duration"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "moving_item_id"
    t.index ["moving_item_id"], name: "index_moving_tasks_on_moving_item_id"
    t.index ["specialty_id"], name: "index_moving_tasks_on_specialty_id"
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
    t.integer "order", default: 1, null: false
    t.bigint "manager_id"
    t.bigint "parent_id"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_orgs_on_admin_id"
    t.index ["manager_id"], name: "index_orgs_on_manager_id"
    t.index ["parent_id"], name: "index_orgs_on_parent_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "org_id"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone_number"
    t.boolean "needs_office_space"
    t.date "from_date"
    t.date "to_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "allocations_count"
    t.index ["org_id"], name: "index_people_on_org_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.integer "order", default: 1, null: false
    t.string "icon"
    t.text "params_script"
    t.text "exec_script"
    t.text "view_script"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled"
  end

  create_table "requirements", force: :cascade do |t|
    t.bigint "org_id"
    t.date "requirement_date"
    t.integer "requirement_type"
    t.date "from_date"
    t.date "to_date"
    t.string "project_name"
    t.integer "facility_criteria"
    t.integer "scientific_criteria"
    t.integer "security_criteria"
    t.text "facility_justification"
    t.text "scientific_justification"
    t.text "security_justification"
    t.text "notes"
    t.bigint "requester_id"
    t.integer "pm_id"
    t.boolean "pm_ok"
    t.integer "manager_id"
    t.boolean "manager_ok"
    t.boolean "authorized_for_allocation"
    t.boolean "allocation_completed"
    t.integer "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "allocations_count"
    t.index ["org_id"], name: "index_requirements_on_org_id"
    t.index ["requester_id"], name: "index_requirements_on_requester_id"
  end

  create_table "space_types", force: :cascade do |t|
    t.string "name"
    t.integer "spaces_count", default: 0
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name"
  end

  create_table "spaces", force: :cascade do |t|
    t.bigint "floor_id"
    t.string "name"
    t.string "function"
    t.string "figure"
    t.string "coor"
    t.string "center_coor"
    t.float "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "space_type_id"
    t.hstore "properties", default: {}
    t.index ["floor_id"], name: "index_spaces_on_floor_id"
    t.index ["space_type_id"], name: "index_spaces_on_space_type_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_defs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buildings_to_man", default: [], array: true
    t.integer "orgs_to_man", default: [], array: true
    t.boolean "man_all_org", default: false
    t.boolean "man_all_building", default: false
    t.string "roles", default: [], array: true
    t.string "username", default: "", null: false
    t.string "email", default: ""
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "language"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wings", force: :cascade do |t|
    t.bigint "building_id"
    t.string "name"
    t.string "short_name"
    t.integer "order", default: 1, null: false
    t.integer "floors_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: true
    t.index ["building_id"], name: "index_wings_on_building_id"
  end

end
