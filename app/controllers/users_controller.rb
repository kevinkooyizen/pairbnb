class UsersController < Clearance::UsersController

  def edit
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_to '/'
    else
      render template: 'users/edit'
    end 
  end

  def show
    @user = current_user
    @listing = Listing.where(user_id: current_user.id)
    render template: 'users/show'
  end

  private

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