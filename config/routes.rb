Rails.application.routes.draw do
  get 'registrations/new'
  get 'registrations/create'
  root to: redirect('registrations/new')

  controller :registrations do
    resources :registrations, only: [:new, :create]
    get 'registrations/complete', action: 'complete'
  end

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
