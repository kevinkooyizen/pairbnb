class StaticController < ApplicationController
	def home
    @listing = Listing.order('created_at DESC').page params[:page]
	end

  def about
  end

  def adminchange
    if admin?
      current_user.update(admin: false, customer: true)
      redirect_to current_user
    else
      if params[:password] == ENV['ADMIN_PASSWORD']
        current_user.update(admin: true, customer: false)
        redirect_to current_user
      else
        @error = "Wrong password"
        render 'admin'
      end
    end
  end
end
