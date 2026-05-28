Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :dogs do
    resources :chats, only: [:create]
  end

  resources :chats, only: [:index, :show] do
    resources :messages, only: [:new, :create, :show]
  end
end
