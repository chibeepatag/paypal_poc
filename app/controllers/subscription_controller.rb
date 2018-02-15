require 'paypal-sdk-rest'
require 'securerandom'

class SubscriptionController < ApplicationController
  include PayPal::SDK::REST
  skip_before_action :verify_authenticity_token 

  def index
  end

  def create_subscription
  	 time = Time.now + 5.minutes

	  agreement_attributes = {
	    "name" => "Premium Subscription for Account Frisbee Test Branch Omron",
	    "description" => "Premium Subscription for Account Frisbee Test Branch Omron",
	    "start_date" => time.iso8601,
	    "payer" => {
	        "payment_method" => "paypal"
	    }   
	  }
    agreement = Agreement.new(agreement_attributes)
    agreement.plan =  Plan.new( :id => "P-7KB30620JA6802433S7TMGJQ" ) #replace with plan id generated in create_plan
    agreement.create

    render :json => agreement.to_json
  end

  def execute_payment
  	#PayPal-Ruby-SDK does not have a method of finding agreement paymentToken. Agreement id is only assigned after executing it
  	#agreement = Agreement.find params[:paymentToken]
  	#agreement.execute
  	api = API.new
  	path = "v1/payments/billing-agreements/#{params[:paymentToken]}/agreement-execute"
    response = api.post(path, {}, { "PayPal-Request-Id" => SecureRandom.uuid.to_s })
    render :json => response.to_json 
  end

  def show
    @agreement = Agreement.find(params[:agreement_id])
  end

  def suspend
    agreement_id = params[:agreement_id]
    agreement = Agreement.find(agreement_id)

    state_descriptor = AgreementStateDescriptor.new( :note => "Suspending the agreement" )
    agreement.suspend(state_descriptor)
    @agreement = Agreement.find(agreement_id)
    render "show"
  end

  def re_activate
    agreement_id = params[:agreement_id]
    agreement = Agreement.find(agreement_id)
    state_descriptor = AgreementStateDescriptor.new( :note => "Re-activating the agreement" )
    agreement.re_activate(state_descriptor)
    @agreement = Agreement.find(agreement_id)
    render "show"
  end

  def cancel
    agreement_id = params[:agreement_id]
    agreement = Agreement.find(agreement_id)
    state_descriptor = AgreementStateDescriptor.new( :note => "Cancelling the agreement" )
    agreement.cancel(state_descriptor)
    @agreement = Agreement.find(agreement_id)
    render "show"
  end

  #Create plan and activate it
  def create_plan
  	planAttributes = {
    "name" => "POC Subscription C4",
    "description" => "Premium Subscription",
    "type" => "INFINITE",
    "payment_definitions" => [
        {
            "name" => "Monthly Premium Subscription",
            "type" => "REGULAR",
            "frequency" => "MONTH",
            "frequency_interval" => "1",
            "amount" => {
                "value" => "30",
                "currency" => "USD"
            },
            "cycles" => "0"            
        }
    ],
    "merchant_preferences" => {
        "return_url" => "http://localhost:3000/subscription/return",
        "cancel_url" => "http://localhost:3000/subscription/cancel",
        "auto_bill_amount" => "YES",
        "initial_fail_amount_action" => "CONTINUE",
        "max_fail_attempts" => "2"
    }
  	}
  	plan = Plan.new(PlanAttributes)
    plan.create #returns true

    logger.info "Plan: #{plan.id}"
    patch = Patch.new
    patch.op = "replace"
    patch.path = "/";
    patch.value = { :state => "ACTIVE" }
    plan.update( patch )
  end

end
