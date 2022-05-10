Rails.application.routes.draw do
  namespace :admin do
    get 'reviews/index'
    get 'reviews/show'
  end
  namespace :admin do
    get 'shops/index'
    get 'shops/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :public do
    get 'reviews/index'
    get 'reviews/show'
    get 'reviews/new'
    get 'reviews/create'
    get 'reviews/edit'
    get 'reviews/update'
    get 'reviews/destroy'
  end
  namespace :public do
    get 'shops/index'
    get 'shops/show'
  end
  get 'homes/top'
  get 'homes/about'
  namespace :public do
    get 'customers/sho'
    get 'customers/edit'
    get 'customers/out'
  end
  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
  }
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
   sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
