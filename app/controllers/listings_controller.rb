class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if params["listing"]["tag_names"].nil?
      @listing.tag_names << params["listing"]["tag_names"]
    end
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
    if params["listing"]["tag_names"].nil?
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
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to "/users/#{current_user.id}"
  end

  def index
    @listing = Listing.all
    if params[:advanced] == "true"
      search_params.each do |key, value|
        if !(value.empty?)
          if key == "initial_price"
            @listing = @listing.send(key, value, params[:final_price])
          elsif key == "final_price" && !params[:initial_price].present?
            @listing = @listing.send(key, value)
          elsif key != "final_price"
            @listing = @listing.send(key, value)
          end
        end
      end
    else
      if params[:search]
        @listing = Listing.search(params[:search]).order("created_at DESC")
      else
        @listing = Listing.all.order("created_at DESC")
      end
    end
  end

  def all
    @listing = Listing.all
    if params[:search]
      @listing = Listing.search(params[:search]).order("created_at DESC")
    else
      @listing = Listing.all.order("created_at DESC")
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @reservation = @listing.reservations.new
    reservations = Reservation.where(listing_id: params[:id]).map{|x| {from: x.check_in_date, to: x.check_out_date.prev_day}}
    gon.reservations = reservations
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

  def verify
    @listing = Listing.find(params[:id])
    if @listing.verification == false
      if allowed?("verify", current_user)
        @listing.update(verification: true)
        flash[:notice] = "Verified."
      else
        flash[:notice] = "Sorry you're not allowed to perform this action."
      end
    else
      flash[:notice] = "Listing already verified."
    end
      render 'edit'
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :address, :property_type, :user_id, :room_number, :guest_number, :country, :state, :city, :zipcode, :price, :description, :bed_number, photos: [])
  end

  def search_params
    params.permit(:search, :initial_price, :final_price, :bed_number, :room_number, :city)
  end
end
