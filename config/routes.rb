Rails.application.routes.draw do
  root to: redirect('inquiries/new')

  controller :inquiries do
    resources :inquiries, only: [:new, :create]
    get 'inquiries/complete', action: 'complete'
  end

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
