Rails.application.routes.draw do
  get 'deputies', to: 'deputies#index'
  get 'deputies/new', to: 'deputies#new'
  post 'deputies/create', to: 'deputies#create'
  get 'deputies/:id/:name', to: 'deputies#show', as: 'deputies/show'

  get 'invoices/charts', to: 'invoices#index'

  root 'deputies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
