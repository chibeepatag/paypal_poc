Rails.application.routes.draw do
  get 'subscription/show'
  get 'subscription/return'
  get 'subscription/cancel'
  post 'subscription/create_subscription'
  post 'subscription/execute_payment'
  
  post 'server_side_payments/create_payment'
  post 'server_side_payments/execute_payment'

  get 'greetings/hello'
  get 'greetings/subscribe'
  get 'greetings/serverside'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
