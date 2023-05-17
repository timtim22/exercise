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

ActiveRecord::Schema[7.0].define(version: 2023_05_16_110845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "excavators", force: :cascade do |t|
    t.string "company_name"
    t.string "address"
    t.boolean "crew_on_site"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "request_number"
    t.integer "sequence_number"
    t.string "request_type"
    t.string "request_action"
    t.jsonb "date_times", default: {}
    t.jsonb "service_area", default: {}
    t.jsonb "digsite_info", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date_times"], name: "index_tickets_on_date_times", using: :gin
    t.index ["digsite_info"], name: "index_tickets_on_digsite_info", using: :gin
    t.index ["service_area"], name: "index_tickets_on_service_area", using: :gin
  end

end
