Rails.application.routes.draw do
  root 'homepage#show'

  resource :sign_in, only: [:new, :create, :destroy]

  resources :conversations
end
