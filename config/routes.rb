Rails.application.routes.draw do
  devise_for :users

  get 'deputies', to: 'deputies#index'
  get 'deputies/new', to: 'deputies#new'
  post 'deputies/create', to: 'deputies#create'
  get 'deputies/:id/:name', to: 'deputies#show', as: 'deputies/show'

  get 'invoices/charts', to: 'invoices#index'

  root 'deputies#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
