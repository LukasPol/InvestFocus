Rails.application.routes.draw do
  unauthenticated :user do
    root to: 'home#index', as: :unauthenticated_user_root
  end

  authenticated :user do
    root to: 'assets#index', as: :authenticated_user_root
  end

  get 'home', to: 'home#index'
  devise_for :users

  resources :assets, only: :index, path: I18n.t('routes.assets')
  resources :tradings, only: :index, path: I18n.t('routes.tradings')
end
