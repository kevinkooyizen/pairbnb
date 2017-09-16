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

  def user_from_params
    user_params = params[:user] || Hash.new
    name = user_params.delete(:name)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.name = name
      user.email = email
      user.password = password
    end
  end
end