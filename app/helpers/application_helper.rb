module ApplicationHelper
  def logged_in?
    !current_user.nil?
  end

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def admin?
    current_user.admin
  end

  def allowed?(action, user)
    case action
    when "verify"
      if user.admin == true 
        return true
      end
    end      
  end
end
