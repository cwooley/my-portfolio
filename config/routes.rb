Rails.application.routes.draw do
  
  resources :topics, only: [:index, :show]

  devise_for :users, path: '', path_names: { sign_in: "login", sign_out: "logout", sign_up: "register"  }
  resources :portfolios do
    put :sort, on: :collection
  end
  
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'tech-news', to: 'pages#tech_news'

  resources :blogs do
    member do
      get :toggle_status
    end
  end

  mount ActionCable.server => '/cable'
  
  root to: 'pages#home'
  
end
