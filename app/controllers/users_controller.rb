class UsersController < Clearance::UsersController

  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @listing = Listing.where(user_id: params[:id])
    render template: 'users/show'
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to "/users/#{current_user.id}"
    else
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end