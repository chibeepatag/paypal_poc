class CheckoutController < ApplicationController
	include PayPalCheckoutSdk::Orders
	include PayPalClient
	
	skip_before_action :verify_authenticity_token 
	layout false
	def index
	end

	def complete
		logger.info(params[:orderID])

		request = OrdersGetRequest::new(params[:orderID])
		request.headers["prefer"] = "return=representation"

   		#3. Call PayPal to get the transaction
	    response = PayPalClient::client::execute(request)
	    #4. Save the transaction in your database. Implement logic to save transaction to your database for future reference.
	    puts "Status Code: " + response.status_code.to_s
	    puts "Status: " + response.result.status
	    puts "Order ID: " + response.result.id
	    puts "Intent: " + response.result.intent
	    puts "Links:"
	    for link in response.result.links
	    	puts "\t#{link["rel"]}: #{link["href"]}\tCall Type: #{link["method"]}"
		end
		puts "Gross Amount: " + response.result.purchase_units[0].amount.currency_code + response.result.purchase_units[0].amount.value	
	end
end

