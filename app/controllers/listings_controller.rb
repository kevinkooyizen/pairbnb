class ListingsController < ApplicationController
  def new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.tag_names << params["listing"]["tag_names"]
    if @listing.save
      redirect_to "/users/#{current_user.id}"
    else
      @errors = @listing.errors.full_messages
      render 'new'
    end 
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :address, :user_id)
  end
end
