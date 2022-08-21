Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "public/homes#top"
  get 'admin' => 'admin/homes#top'
  get 'about' => 'public/homes#about'

  # public/customer
  get 'customers/my_page' => 'public/customers#show'
  get 'customers/information/edit' => 'public/customers#edit'
  patch 'customers/information' => 'public/customers#update'
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw'

  # public/addresses
  get 'addresses' => 'public/addresses#index'
  post 'addresses' => 'public/addresses#create'
  get 'addresses/:id/edit' => 'public/addresses#edit'
  patch 'addresses/:id' => 'public/addresses#update'
  delete 'addresses/:id' => 'public/addresses#destroy'

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
    resources :homes, only: [:top]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  namespace :public do
  end

end