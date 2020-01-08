Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' }
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'post#index'
    get 'posts', to: 'post#index'
    get 'posts/new', to: 'post#new'
    post 'posts', to: 'post#create'
    get 'posts/:id', to: 'post#show', as: :post
    get 'posts/:id/edit', to: 'post#edit', as: :edit_post
    patch 'posts/:id', to: 'post#update'
    delete 'posts/:id/delete', to: 'post#destroy', as: :delete_post
end