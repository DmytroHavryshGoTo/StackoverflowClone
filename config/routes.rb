Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'questions#index'

  resources :questions do
    resources :answers do
      post 'mark_best', on: :member
    end
  end

  resources :attachments, only: [:destroy]
end
