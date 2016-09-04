Rails.application.routes.draw do
	get 'pages/home'
  get 'pages/about'
  get 'pages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#hello'
  root 'pages#home'
end
