module ReviewsHelper
  # This method checks if a user exists in the database.
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
end