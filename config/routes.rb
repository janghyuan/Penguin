Rails.application.routes.draw do
	get 'pages/home'
  get 'pages/about'
  get 'pages/help'
  get 'home', to: 'pages#home'
  get 'help', to: 'pages#help'
  get 'about', to: 'pages#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#hello'
  root 'pages#home'

  resources :users
  # 用户注册
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # 用户登录
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
