# db/migrate/20240313215936_update_schema_from_current_state.rb

class UpdateSchemaFromCurrentState < ActiveRecord::Migration[7.1]
  def change
    # Drop existing tables
    drop_table :categories
    drop_table :order_details
    drop_table :orders
    drop_table :permissions
    drop_table :products
    drop_table :reviews
    drop_table :role_permissions
    drop_table :roles
    drop_table :user_roles
    drop_table :users

    # Recreate tables with updated structure
    create_table "categories", force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "order_details", force: :cascade do |t|
      t.integer "order_id", null: false
      t.integer "product_id", null: false
      t.integer "quantity", null: false
      t.decimal "price", precision: 10, scale: 2, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["order_id"], name: "index_order_details_on_order_id"
      t.index ["product_id"], name: "index_order_details_on_product_id"
    end

    create_table "orders", force: :cascade do |t|
      t.integer "user_id", null: false
      t.datetime "order_date", default: -> { "CURRENT_TIMESTAMP" }
      t.decimal "total_amount", precision: 10, scale: 2, null: false
      t.string "status", default: "Pending"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_orders_on_user_id"
    end

    create_table "permissions", force: :cascade do |t|
      t.string "name", limit: 100, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "products", force: :cascade do |t|
      t.string "name", null: false
      t.text "description"
      t.decimal "price", precision: 10, scale: 2, null: false
      t.integer "stock_quantity", null: false
      t.integer "category_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["category_id"], name: "index_products_on_category_id"
    end

    create_table "reviews", force: :cascade do |t|
      t.integer "user_id", null: false
      t.integer "product_id", null: false
      t.integer "rating", null: false
      t.text "comment"
      t.datetime "review_date", default: -> { "CURRENT_TIMESTAMP" }
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["product_id"], name: "index_reviews_on_product_id"
      t.index ["user_id"], name: "index_reviews_on_user_id"
    end

    create_table "role_permissions", force: :cascade do |t|
      t.integer "role_id", null: false
      t.integer "permission_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
      t.index ["role_id"], name: "index_role_permissions_on_role_id"
    end

    create_table "roles", force: :cascade do |t|
      t.string "name", limit: 50, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "user_roles", force: :cascade do |t|
      t.integer "user_id", null: false
      t.integer "role_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["role_id"], name: "index_user_roles_on_role_id"
      t.index ["user_id"], name: "index_user_roles_on_user_id"
    end

    create_table "users", force: :cascade do |t|
      t.string "name", limit: 50, null: false
      t.string "last_name"
      t.string "email", limit: 100, null: false
      t.string "password", limit: 100, null: false
      t.datetime "registration_date", default: -> { "CURRENT_TIMESTAMP" }
      t.string "address_1", limit: 255
      t.string "address_2", limit: 255
      t.string "state", limit: 50
      t.string "gender"
      t.date "birth_date"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_foreign_key "order_details", "orders"
    add_foreign_key "order_details", "products"
    add_foreign_key "orders", "users"
    add_foreign_key "products", "categories"
    add_foreign_key "reviews", "products"
    add_foreign_key "reviews", "users"
    add_foreign_key "role_permissions", "permissions"
    add_foreign_key "role_permissions", "roles"
    add_foreign_key "user_roles", "roles"
    add_foreign_key "user_roles", "users"
  end
end

