Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'questions#index'

  resources :questions do
    resources :answers do
      post 'mark_best', on: :member
    end
  end

  resources :attachments, only: [:destroy]

  namespace :api do
    namespace :v0 do
      resource :profiles do
        get :me, on: :collection
      end
    end
  end
end
