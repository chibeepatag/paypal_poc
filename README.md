# paypal_poc

This rails project uses [PayPal's ruby sdk](https://github.com/paypal/PayPal-Ruby-SDK)

0. Replace client_id and client_secret in config/paypal.yml
1. bundle install
2. rails s
3. visit 
* http://localhost:3000/greetings/hello #for client side payments
* http://localhost:3000/greetings/serverside # for server side payments
* http://localhost:3000/greetings/subscribe #for subscription using PayPal button provided in merchant account
* http://localhost:3000/subscription/show #for server side subscription