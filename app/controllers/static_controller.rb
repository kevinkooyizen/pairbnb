class StaticController < ApplicationController
	def home
    @listing = Listing.page params[:page]
	end

  def about
  end
end
