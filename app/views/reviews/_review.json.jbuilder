json.extract! review, :id, :user_id, :product_id, :rating, :comment, :review_date, :created_at, :updated_at
json.url review_url(review, format: :json)
