Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  resources :vessels do
    resources :vessel_options
    resources :reviews
    resources :bookings, only: [:show, :create], shallow: true do
      resources :selected_options
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
