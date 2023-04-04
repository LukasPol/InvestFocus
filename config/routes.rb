require 'sidekiq/web'

Rails.application.routes.draw do
  default_url_options host: ENV['DOMAIN_NAME']

  mount Sidekiq::Web => '/sidekiq'

  unauthenticated :user do
    root to: 'home#index', as: :unauthenticated_user_root
  end

  authenticated :user do
    root to: 'assets#index', as: :authenticated_user_root
  end

  get 'home', to: 'home#index'
  devise_for :users

  resources :assets, only: :index, path: I18n.t('routes.assets')
  resources :tradings, only: [:index, :new, :create], path: I18n.t('routes.tradings')
  resources :importer, only: [:new, :create]
  resources :proceeds, only: [:index, :new, :create], path: I18n.t('routes.proceeds')
end
