class HomeController < ApplicationController
  before_action :set_cart_count

  def index
    @category = Category.all
 
  end

  def show_products_by_category
    @category = Category.find(params[:category_id])
    @products = @category.products
    @cart_count = session[:cart].values.sum
  end

# add to cart from cart page
  def add
    flash[:notice] = "Product added to cart."
    product_id = params[:product_id]
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    @cart_count = session[:cart].values.sum
  
    respond_to do |format|
      format.turbo_stream do

        render turbo_stream: [turbo_stream.update("cart-count", partial: "layouts/shareshome/cart_count", locals: { cart_count: @cart_count }),
        
        turbo_stream.update("product_#{product_id}", partial: "home/card_cart", locals: { product: Product.find(product_id), quantity: session[:cart][product_id] }),
        turbo_stream.update("flash", partial: "layouts/shareshome/flash"),
    
      ]
      end
    end
  end

  # add to cart from home page

  def add_to_cart
    flash[:notice]= "Product added to  cart from home ."
    product_id = params[:product_id]
    session[:cart] ||= {}
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += 1
    @cart_count = session[:cart].values.sum
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.update("cart-count", partial: "layouts/shareshome/cart_count", locals: { cart_count: @cart_count }),
        turbo_stream.update("flash", partial: "layouts/shareshome/flash")
      ]
      end
    end
  end


  def remove 
    flash[:alert]= "Product removed from cart."
  product_id = params[:product_id]
  session[:cart][product_id] -= 1
  if session[:cart][product_id] <= 0
    session[:cart].delete(product_id)
  end
  @cart_count = session[:cart].values.sum
  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.update("cart-count", partial: "layouts/shareshome/cart_count", locals: { cart_count: @cart_count }),
        (session[:cart][product_id].to_i <= 0 ? 
          turbo_stream.remove("product_#{product_id}") : 
          turbo_stream.update("product_#{product_id}", partial: "home/card_cart", locals: { product: Product.find(product_id), quantity: session[:cart][product_id] })
        ),
        turbo_stream.update("flash", partial: "layouts/shareshome/flash")
      ]

    end
  end
end


  def cart
    @cart = {}
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @cart[product] = quantity
    end
  end

  
def set_cart_count
    session[:cart] ||= {}
    @cart_count = session[:cart].values.sum
end

  

  def home_params
    params.require(:category).permit(:name)
  end


end
