# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160303235739) do

  create_table "beacons", :force => true do |t|
    t.integer  "place_id"
    t.float    "coord_x"
    t.float    "coord_y"
    t.float    "coord_z"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "mac"
  end

  create_table "finger_prints", :force => true do |t|
    t.integer  "place_id"
    t.float    "xcoord"
    t.float    "ycoord"
    t.string   "BSSID"
    t.string   "SSID"
    t.float    "RSSI"
    t.float    "SD"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "mac"
  end

  create_table "magnetic_finger_prints", :force => true do |t|
    t.float    "place_id"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.float    "angle"
    t.float    "magnitude"
    t.integer  "magnetic_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "magnetics", :force => true do |t|
    t.float    "place_id"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.float    "angle"
    t.float    "magnitude"
    t.float    "xcoord"
    t.float    "ycoord"
    t.float    "xsd"
    t.float    "ysd"
    t.float    "zsd"
    t.float    "magnitudesd"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "range"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "address"
    t.string   "map_file_name"
    t.string   "map_content_type"
    t.integer  "map_file_size"
    t.datetime "map_updated_at"
    t.string   "maplink"
  end

  create_table "routers", :force => true do |t|
    t.string   "mac"
    t.float    "coord_x"
    t.float    "coord_y"
    t.float    "coord_z"
    t.integer  "place_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "wifi_finger_prints_records", :force => true do |t|
    t.integer  "fingerprint_id"
    t.string   "BSSID"
    t.string   "SSID"
    t.integer  "RSSI"
    t.integer  "channel"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "mac"
  end

end
