class ApplicationController < ActionController::Base
    include Pagy::Backend
    protect_from_forgery with: :exception
    before_action :set_categories

    private
  
    def set_categories
      @categories = Category.all 
    end
    
    def current_or_guest_user
      if user_signed_in?
        current_user
      else
        User.new(name: 'Guest')
      end
    end
    helper_method :current_or_guest_user
end
