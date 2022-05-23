Rails.application.routes.draw do

  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  root to: 'homes#top'
  get '/home/about' => 'homes#about', as: "about"

  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ゲストログイン
  devise_scope :customer do
    post 'customers/guest_sign_in' => 'customers/sessions#guest_sign_in'
  end


  # 顧客用
  scope module: :public do
    get 'shops/search' => 'shops#search'
    get '/customer/out' => 'public/customers#out', as: 'out'
    patch '/customer/quit' => 'public/customers#quit', as: 'quit'
    resources :customers, only: [:show, :edit, :update]
    resources :shops, only: [:index, :show] do
      resources :reviews, except: [:new] do
        resource :comments, only: [:create]
        resource :favorites, only: [:create, :destroy]
      end
    end
    resources :comments, only: [:destroy]
    resources :tags do
      get 'reviews' => 'reviews#search'
    end
  end

  # 管理者用
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :shops, only: [:index, :show]
    resources :reviews, only: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
