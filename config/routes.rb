Rails.application.routes.draw do


  root 'searches#new'
  post 'searches/new'

  get 'home/profile'
  # get 'searches/new'

  resources :searches


  get '/auth/:provider/callback', to: "sessions#create"
  delete 'log_out', to: "sessions#destroy", as: "log_out"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
