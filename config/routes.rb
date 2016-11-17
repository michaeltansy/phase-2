Rails.application.routes.draw do
  get 'size/index'
  get 'size/retrieveSize'
  post 'size/create'

  get 'menu/index'
  post 'menu/create'
  get 'menu/retrieveMenu'

  get 'order/index'
  post 'order/addOrder'
  post 'order/create'
  post 'order/typeSelect'
  get 'order/changeOrder'
  get 'order/orderData'
  get 'order/groupData'
  post 'order/addChange'
  get 'welcome/index'

  root 'order#index'

  resources :scripts do
    member do
      get 'fileContent'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
