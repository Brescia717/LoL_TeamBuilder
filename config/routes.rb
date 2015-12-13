require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :teams do
    resources :comments
  end
  resources :users do
    resources :bios
    resources :stats
    member do
      put "like", to: "users#upvote"
      put "dislike", to: "users#downvote"
    end
  end

  root 'welcome#index'

  if Rails.env.development?
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
