class NewSubscriptionsController < ApplicationController
	skip_before_action :verify_authenticity_token 
	layout false
	def index
	end
end
