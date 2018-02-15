require 'paypal-sdk-rest'
class PaymentsController < ApplicationController
  include PayPal::SDK::REST
  skip_before_action :verify_authenticity_token 
  def clientside
  	
  end

  def subscribe
  end

  def serverside
  end

  def create_payment
  	@payment = Payment.new({
	  :intent =>  "sale",
	  :payer =>  {
	    :payment_method =>  "paypal" },
	  :redirect_urls => {
	    :return_url => "http://localhost:3000/server_side_payments/execute_payment",
	    :cancel_url => "http://localhost:3000/server_side_payments/cancel_payment" },
	  :transactions =>  [{
	    :item_list => {
	      :items => [{
	        :name => "Frisbee Toy",
	        :sku => "FB-1997",
	        :price => "12",
	        :currency => "USD",
	        :quantity => 1 }]},
	    :amount =>  {
	      :total =>  "12",
	      :currency =>  "USD" },
	    :description =>  "Frisbee's Favorite Toys" }]})

	if @payment.create
	  @payment.id     # Payment Id
	else
	  @payment.error  # Error Hash
	end
	logger.info "Payment[#{@payment.id}]"
	render :json => @payment
  end

  def execute_payment
  	paymentID = params[:paymentID]
	payerID = params[:payerID]
  	payment = Payment.find(paymentID)
	if payment.execute( :payer_id => payerID )
		payment = Payment.find(paymentID)
		render plain: payment.state
	else
	  Rails.logger.info payment.error # Error Hash
	  render status: 500
	end
  end
end
