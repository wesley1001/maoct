Rails.application.routes.draw do
  root to: 'home#index'

  post 'wx_pay' => 'home#wx_pay'
  post 'wx_notify' => 'home#wx_notify'

  get  'goto_pay' => 'pay#new'
  post 'pay' => 'pay#create'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resource :wechat, only: [:show, :create]
  resources :meetups
  resources :meetup_enrolls, only: [:index, :create, :show]
end
