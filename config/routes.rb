Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create, :edit, :show, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings
    resources :reservations
  end

  get "/listings" => "listings#all", as: "all_listings"
  get "/listings/:id/verify" => "listings#verify", as: "verify_listing"

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static#home'
  get '/auth/:provider/callback' => 'sessions#create_from_omni_auth'
  get "/listings/:id/remove_tag/:name" => "listings#remove_tag", as: "remove_tag"
  get "/listings/:id/add_tag" => "listings#add_tag", as: "add_tag"
  get '/about' => "static#about", as: "about"
end
