# paypal_poc

This rails project uses [PayPal's ruby sdk](https://github.com/paypal/PayPal-Ruby-SDK)

0. rails g paypal:sdk:install
1. Replace client_id and client_secret in config/paypal.yml
2. bundle install
3. rails s
4. visit 
* http://localhost:3000/payments/clientside #for client side payments
* http://localhost:3000/payments/serverside # for server side payments
* http://localhost:3000/payments/subscribe #for subscription using PayPal button provided in merchant account
* http://localhost:3000/subscription/show #for server side subscription