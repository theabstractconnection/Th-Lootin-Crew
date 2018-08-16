Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :vessels do
    resources :vessel_options, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
    resources :bookings, only: [:show, :create], shallow: true do
      resources :selected_options, only: [:create]
    end
  end
  post "search" => "vessels#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
