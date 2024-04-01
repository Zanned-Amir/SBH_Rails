json.extract! user, :id, :name, :last_name, :email, :password, :registration_date, :address_1, :address_2, :state, :gender, :birth_date, :created_at, :updated_at
json.url user_url(user, format: :json)
