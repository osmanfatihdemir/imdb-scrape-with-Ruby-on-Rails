Rails.application.routes.draw do

  get "about-us", to:"about#index", as: :about

  
  get "password",to:"passwords#edit", as: :edit_password
  patch "password",to:"passwords#update"

  get "sign_up",to:"registrations#new"
  post "sign_up",to:"registrations#create"

  get "sign_in",to:"sessions#new"
  post "sign_in",to:"sessions#create"

  delete "logout",to:"sessions#destroy"

  root to:"movies#index"

  post "movie_user_claim_add",to:"movies#userAddMovie"
  
  delete "movie_user_claim_delete",to:"movies#userDeleteMovie"

  resources :movies do 
    match '/scrape', to: 'movies#scrape', via: :post, on: :collection
  end

  get "mymovies",to:"movies#getMyMovie"
  
  get "recommends", to:"recommends#index"

  resources :recommends do 
    match '/recommends/scrape', to: 'recommends#scrape', via: :post, on: :collection
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
