json.extract! order_detail, :id, :order_id, :product_id, :quantity, :price, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
