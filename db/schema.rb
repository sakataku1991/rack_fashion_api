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

ActiveRecord::Schema.define(version: 2022_03_07_001707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_category_maps", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_question_category_maps_on_category_id"
    t.index ["question_id"], name: "index_question_category_maps_on_question_id"
  end

  create_table "question_color_maps", force: :cascade do |t|
    t.bigint "color_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["color_id"], name: "index_question_color_maps_on_color_id"
    t.index ["question_id"], name: "index_question_color_maps_on_question_id"
  end

  create_table "question_hashtag_maps", force: :cascade do |t|
    t.bigint "hashtag_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hashtag_id"], name: "index_question_hashtag_maps_on_hashtag_id"
    t.index ["question_id"], name: "index_question_hashtag_maps_on_question_id"
  end

  create_table "question_post_status_maps", force: :cascade do |t|
    t.bigint "post_status_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_status_id"], name: "index_question_post_status_maps_on_post_status_id"
    t.index ["question_id"], name: "index_question_post_status_maps_on_question_id"
  end

  create_table "question_sex_maps", force: :cascade do |t|
    t.bigint "sex_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_question_sex_maps_on_question_id"
    t.index ["sex_id"], name: "index_question_sex_maps_on_sex_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "image"
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_questions_on_user_id_and_created_at", unique: true
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "sexes", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "alias", null: false
  end

  create_table "user_sex_maps", force: :cascade do |t|
    t.bigint "sex_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sex_id"], name: "index_user_sex_maps_on_sex_id"
    t.index ["user_id"], name: "index_user_sex_maps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "rack_id", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "activated", default: false, null: false
    t.boolean "admin", default: false, null: false
    t.boolean "guest", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "refresh_jti"
    t.datetime "activated_at"
    t.string "activation_digest"
    t.text "profile", default: "よろしくお願いします。", null: false
    t.string "instagram"
    t.string "twitter"
    t.text "homepage"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "question_category_maps", "categories"
  add_foreign_key "question_category_maps", "questions"
  add_foreign_key "question_color_maps", "colors"
  add_foreign_key "question_color_maps", "questions"
  add_foreign_key "question_hashtag_maps", "hashtags"
  add_foreign_key "question_hashtag_maps", "questions"
  add_foreign_key "question_post_status_maps", "post_statuses"
  add_foreign_key "question_post_status_maps", "questions"
  add_foreign_key "question_sex_maps", "questions"
  add_foreign_key "question_sex_maps", "sexes"
  add_foreign_key "questions", "users"
  add_foreign_key "user_sex_maps", "sexes"
  add_foreign_key "user_sex_maps", "users"
end
