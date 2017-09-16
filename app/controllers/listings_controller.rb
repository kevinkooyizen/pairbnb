class ListingsController < ApplicationController
  def new
    @listing = Listing.new
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
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
    if !params["listing"]["tag_names"].nil?
      @listing.tag_names << params["listing"]["tag_names"]
    end
    if @listing.save
      redirect_to "/users/#{current_user.id}"
    else
      @errors = @listing.errors.full_messages
      render 'edit'
    end 
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def destroy
  end

  def index
  end

  def show
  end

  def add_tag
    @listing = Listing.find(params[:id])
  end

  def remove_tag
    @listing = Listing.find(params[:id])
    @listing.tag_names.delete(params["name"])
    @listing.save
    redirect_to "/users/#{current_user.id}"
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :address, :user_id)
  end
end
