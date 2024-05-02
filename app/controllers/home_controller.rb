class HomeController < ApplicationController
  layout 'application'
  before_action :set_cart_count

  def descover

  end

  def index
    @q =  Product.where(active: true).ransack(params[:q])
    @pagy , @products = pagy(@q.result(distinct: true),items: 10 )

    respond_to do |format|
      format.html 
      format.turbo_stream 
    end
  end
  
  def show_product
    @product = Product.find(params[:id])
    render layout: 'stuff'
  end


  def show_products_by_category
    @category = Category.find(params[:category_id])
    @q = @category.products.where(active: true).ransack(params[:q])

  @pagy, @products = pagy(@q.result(distinct: true), items: 10)
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

  def checkout
    if user_signed_in?
      # Check if the cart is empty
      if session[:cart].blank?
        flash[:alert] = "Your cart is empty. Please add some products before checking out."
        redirect_to root_path and return
      else 
        redirect_to order_confirmation_path()
      
      end
      
    else
      flash[:alert] = "You need to sign in before saving the order"
      redirect_to new_user_session_path
    end
  end


  def order_confirmation
    if user_signed_in?
      if session[:cart].blank?
        flash[:alert] = "Your cart is empty. Please add some products before confirming the order."
        redirect_to root_path
      else
        @cart_items = session[:cart].map do |product_id, quantity|
          product = Product.find_by(id: product_id)
          { product: product, quantity: quantity } if product
        end.compact
      end
    else
      flash[:alert] = "You need to sign in before confirming the order"
      redirect_to new_user_session_path
    end
  end
  
  def save_order
    if user_signed_in?
      # Check if the cart is empty
      if session[:cart].blank?
        flash[:error] = "Your cart is empty."
        redirect_to root_path and return
      else
        process_order
      end
  
    else
      flash[:error] = "You must be signed in to save an order."
      redirect_to new_user_session_path
    end
  end

  private
  def process_order
    order = current_user.orders.build(total_amount: calculate_total_price, status: "Pending")
  
    if order.save
      session[:cart].each do |product_id, quantity|
        product = Product.find(product_id)
        order.order_details.create(product: product, quantity: quantity, price: product.price)
      end
      session[:cart] = {} # Clear the cart
      flash[:notice] = "Order and order details saved successfully"
    else
      flash[:alert] = "Failed to save order"
      redirect_back fallback_location: root_path
    end
  end


    

  def set_cart_count
    session[:cart] ||= {}
    @cart_count = session[:cart].values.sum
  end

  def calculate_total_price
    total_price = 0
  
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      total_price += product.price * quantity
    end
  
    total_price
  end

   
  
  def order_params
    params.require(:order).permit(:status, :total_amount) rescue nil
  end



end
