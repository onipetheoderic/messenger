Rails.application.routes.draw do
  get 'messages/index'

  get 'conversations/index'

  devise_for :users
  root "conversations#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :conversations do
  	resources :messages
  end
end
#so now we make sure we have the conversations and messages controller created, with the index and create methods
