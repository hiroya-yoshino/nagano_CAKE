Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "homes#top"
  
  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
  end

end