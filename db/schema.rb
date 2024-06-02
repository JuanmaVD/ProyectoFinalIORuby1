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

ActiveRecord::Schema[7.1].define(version: 2024_06_02_195402) do
  create_table "categories", force: :cascade do |t|
    t.string "nombreCategoria"
    t.string "descripcionCategoria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "nombreCliente"
    t.string "apellidoCliente"
    t.string "mailCliente"
    t.integer "telefonoCliente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "demands", force: :cascade do |t|
    t.integer "demandaReal"
    t.integer "demandaProyectada"
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_demands_on_product_id"
  end

  create_table "product_purchase_orders", force: :cascade do |t|
    t.float "totalCostoOrdenCompraProducto"
    t.integer "cantOrdenCompraProducto"
    t.float "subTotalCostoOrdenCompraProducto"
    t.integer "product_id"
    t.integer "purchase_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_purchase_orders_on_product_id"
    t.index ["purchase_order_id"], name: "index_product_purchase_orders_on_purchase_order_id"
  end

  create_table "product_sales", force: :cascade do |t|
    t.float "totalCostoVentaProducto"
    t.integer "cantVentaProducto"
    t.float "subTotalVentaProducto"
    t.integer "sale_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_sales_on_product_id"
    t.index ["sale_id"], name: "index_product_sales_on_sale_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "nombreProducto"
    t.string "descripcionProducto"
    t.float "precioProveedorProducto"
    t.float "precioVentaProducto"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "nombreProveedor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.float "totalCostoOrdenCompra"
    t.string "estadoOrdenCompra"
    t.datetime "fechaEstimadaEntrega"
    t.integer "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_purchase_orders_on_provider_id"
  end

  create_table "sales", force: :cascade do |t|
    t.float "totalCostoVenta"
    t.string "estadoVenta"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_sales_on_client_id"
  end

  add_foreign_key "demands", "products"
  add_foreign_key "product_purchase_orders", "products"
  add_foreign_key "product_purchase_orders", "purchase_orders"
  add_foreign_key "product_sales", "products"
  add_foreign_key "product_sales", "sales"
  add_foreign_key "products", "categories"
  add_foreign_key "purchase_orders", "providers"
  add_foreign_key "sales", "clients"
end
