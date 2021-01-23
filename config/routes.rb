Rails.application.routes.draw do
  root 'inquiries#new'
  resources :users
  resources :inquiries
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
