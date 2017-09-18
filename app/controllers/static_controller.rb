class StaticController < ApplicationController
	def home
    @listing = Listing.order('created_at DESC').page params[:page]
	end

  def about
  end
end
