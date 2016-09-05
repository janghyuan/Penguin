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

  # 用户注册
  get 'signup', to: 'users#new'
end
