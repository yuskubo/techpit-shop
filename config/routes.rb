Rails.application.routes.draw do
  root to: redirect('events')

  resources :registrations, only: [:create]
  get 'registrations/complete', to: 'registrations#complete'

  resources :events, only: [:index, :show] do
    resources :registrations, only: [:create]
  end

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
