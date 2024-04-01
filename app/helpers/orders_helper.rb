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
  end
  
