json.extract! order, :id, :user_id, :order_date, :total_amount, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
