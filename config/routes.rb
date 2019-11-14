Rails.application.routes.draw do
  root 'homepage#show'

  resource :sign_in, only: [:new, :create, :destroy]

  resources :conversations, except: [:destroy, :edit, :update] do
    resources :messages, only: [:create]
  end
end
