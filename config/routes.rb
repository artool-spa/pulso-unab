Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }, path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: "clients#index"

  resources :users, shallow: true
  resources :clients, shallow: true
end
