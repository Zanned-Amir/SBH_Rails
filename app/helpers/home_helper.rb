module HomeHelper

    def calculate_total_price
        @cart = {}
        session[:cart].each do |product_id, quantity|
          product = Product.find(product_id)
          @cart[product] = quantity
        end
       @cart.sum { |product, quantity| product.price * quantity }
      end
end
