module OrdersHelper
    def status_color_class(status)
      case status
      when 'pending'
        'text-warning' # Bootstrap class for warning color
      when 'confirmed'
        'text-success' # Bootstrap class for success color
      when 'shipped'
        'text-primary' # Bootstrap class for primary color
      when 'delivered'
        'text-info'    # Bootstrap class for info color
      when 'canceled'
        'text-danger'  # Bootstrap class for danger color
      else
        ''
      end
    end

    def user_exists?(user_name)
      User.find_by(name: user_name).present?
    end
  
    def user_status_message(user)
      if user && user_exists?(user.name)
        user.name
      else
        "User doesn't exist or has been deleted in a previous action."
      end
    end
  
    def user_status_message1(user)
      if user && user_exists?(user.name)
        user.name
      else
        "NaN"
      end
    end
  end
  
