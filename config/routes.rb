Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }, path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: "semaphore#index"

  resources :users, shallow: true
  resources :clients, shallow: true

  resources :semaphore, only: [:index, :show] do
    collection do
      post 'budgets_save'
    end
    member do
      delete 'remove_campaign_label'
    end
  end

end
