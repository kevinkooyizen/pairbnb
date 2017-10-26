require 'rails_helper'

RSpec.describe ReservationsController, type: [:controller] do
  When(:user) { User.create(
      id: 1,
      first_name: "Raz",
      email: "raz@nextacademy.com",
      password: "123456",
      password_confirmation: "123456"
    )}

  let(:listing) { Listing.create(
    id: 1,
    user_id: 1,
    name: "Dog House",
    address: "Jalan Anjing",
    guest_number: 2)}


  # let(:reservation) { Reservation.create(
  #   user_id: 1,
  #   listing_id: 1,
  #   number_of_guests: 2,
  #   check_in_date: Date.new(2017,1,30),
  #   check_out_date: Date.today)}

  let(:valid_params) {{ 
    user_id: 1,
    listing_id: 1,
    number_of_guests: 2,
    check_in_date: Date.new(2017,1,30),
    check_out_date: Date.today}}

  let(:invalid_params) {{ 
    user_id: 1,
    listing_id: 1,
    number_of_guests: 3,
    check_in_date: "2017,1,29 to 2017,1,30"}}


  describe "GET #new" do

    before do
      sign_in_as(user)
        post :create, params: {
          reservation: {
            check_in_date: "2018-1-29 to 201-81-30",
            number_of_guests: 1,
            listing_id: listing.id
          },
          user_id: 1  ,
          listing_id: listing.id,
        }

      reservation = Reservation.last
      params = { id: reservation.id }
      get :new, params: params
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "asssings braintree token" do
      expect(assigns[:client_token]).not_to be_nil
    end
  end


  describe "POST #create" do
    # happy_path
    
    context "valid_params" do

      it "creates new reservation if params are correct" do
        sign_in_as(user)
        expect {post :create, params: {
          reservation: {
            check_in_date: "2018-1-29 to 2018-1-30",
            number_of_guests: 1,
            listing_id: listing.id
          },
          user_id: 1,
          listing_id: listing.id,
        }
        }.to change(Reservation, :count).by(1)
      end

      it 'redirects to user path and displays flash notice after user created successfully' do
        sign_in_as(user)
        post :create, params: {
          reservation: {
            check_in_date: "2018-1-29 to 2018-1-30",
            number_of_guests: 1,
            listing_id: listing.id
          },
          user_id: 1  ,
          listing_id: listing.id,
        }
        reservation = Reservation.last
        expect(response).to redirect_to reservation_path(reservation)
        # expect(flash[:notice]).to eq "Account created. Please log in now."
      end
    end

    # unhappy_path
    # context "invalid_params" do
    #   before do
    #     post :create, user: invalid_params
    #   end

    #   it "displays flash alert message" do
    #     expect(flash[:alert]).to include "Error creating account: "
    #   end

    #   it "renders new template again" do
    #     expect(response).to render_template("new")
    #   end
    # end
  end



  # describe "GET #edit" do
  #   before do
  #     session[:user_id] = user.id
  #     get :edit, {:id => user.to_param}
  #   end

  #   it "returns http success" do
  #     expect(response).to have_http_status(:success)
  #   end

  #   it "renders the edit template" do
  #     expect(response).to render_template("edit")
  #   end

  # end


  # describe "PUT #update" do
  # # happy_path
  #   context "with valid update params" do
  #     it "updates the requested user" do
  #       user = user1
  #       put :update, {:id => user.to_param, :user => valid_params_update}
  #       user.reload
  #       expect( user.email ).to eq valid_params_update[:email]
  #     end

  #     it 'redirects to user path and displays flash notice after user profile is updated successfully' do

  #       put :update, {:id => user.to_param, :user => valid_params_update}
  #       user.reload
  #       expect(response).to redirect_to(user_path(user))
  #       expect(flash[:notice]).to eq "Account is updated successfully."
  #     end
  #   end
  #   # unhappy_path
  #   context "with invalid update params" do
  #     it "re-renders the 'edit' template" do
  #       put :update, {:id => user.to_param, :user => invalid_params_update}
  #       expect(response).to render_template("edit")
  #     end
  #   end

  # end


  # describe "DELETE #destroy" do

  #   it "destroys the requested user" do
  #     user = user1
  #     expect {
  #       delete :destroy, {:id => user.to_param}
  #     }.to change(User, :count).by(-1)
  #   end

  #   it "redirects to the statuses_path" do
  #     user = user1
  #     delete :destroy, {:id => user.to_param}
  #     expect(response).to redirect_to(statuses_path)
  #     expect(flash[:notice]).to eq "Account is deleted"
  #   end
  # end

end
