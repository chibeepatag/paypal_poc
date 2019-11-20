Rails.application.routes.draw do
  get 'subscription/index'
  get 'subscription/show'
  get 'subscription/suspend'
  get 'subscription/re_activate'
  get 'subscription/cancel'
  post 'subscription/create_subscription'
  post 'subscription/create_subscription_without_setup'
  post 'subscription/create_subscription_with_setup'
  post 'subscription/execute_payment'
  
  post 'payments/create_payment'
  post 'payments/execute_payment'
  get 'payments/clientside'
  get 'payments/subscribe'
  get 'payments/serverside'

  get 'peso/clientside'

  get 'checkout/index'
  post 'checkout/complete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
