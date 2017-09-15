class ListingsController < ApplicationController
  def new
  end

  def create
    @listing = Listing.new(name: listing_name, user_id: current_user.id, address: listing_address)
    if @listing.save
      redirect_to "/users/#{current_user.id}"
    else
      render template: 'listings/edit'
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

  def listing_name
    params["listing"]["name"]
  end

  def listing_address
    params["listing"]["address"]
  end
end
