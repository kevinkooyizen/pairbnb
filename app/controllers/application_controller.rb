class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  def allowed?(action, user)
    case action
    when "verify"
      if user.admin == true 
        return true
      end
    end      
  end
end
