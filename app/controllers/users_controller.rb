class UsersController < Clearance::UsersController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    if @user.reservations.any?
      @reservations = @user.reservations
    else
      @reservations = nil
    end
    @listing = Listing.where(user_id: params[:id])
    render template: 'users/show'
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to "/users/#{current_user.id}"
    else
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :photo)
  end
end