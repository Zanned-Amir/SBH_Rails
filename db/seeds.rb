require 'faker'
30.times do
    Product.create!(
      name: Faker::Commerce.product_name, # using the Faker gem to generate a product name
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 10.0..100.0, as_string: true),
      stock_quantity: Faker::Number.between(from: 1, to: 100),
      category_id: [1,5,6].sample, # randomly assigns a category_id from the array
      active: [true, false].sample # randomly sets active to either true or false
    )
  end
