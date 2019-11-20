require 'paypal-checkout-sdk'

module PayPalClient
  class << self

    # Set up and return PayPal Ruby SDK environment with PayPal access credentials.
    # This sample uses SandboxEnvironment. In production, use LiveEnvironment.
    def environment
      client_id = 'ASJFwR7mZgiNXsjMGQo56NghYpR21wEPnqsECQdWKoaXaTaMb_S_tdEB9KZiZyjHRjoUDdL42P4c4XcL'
      client_secret = 'EH-KW2dQeeYZ-YkLWpZeEZb5ZyxWEi-1jVRetS6dgWyBI7R9AGSfUF_quYVqpQc1RVTUI5KFu3kn6ekm'
      PayPal::SandboxEnvironment.new(client_id, client_secret)
    end

    # Returns PayPal HTTP client instance with environment that has access
    # credentials context. Use this instance to invoke PayPal APIs, provided the
    # credentials have access.
    def client
      PayPal::PayPalHttpClient.new(self.environment)
    end

    # Utility to convert Openstruct Object to JSON hash.
    def openstruct_to_hash(object, hash = {})
      object.each_pair do |key, value|
        hash[key] = value.is_a?(OpenStruct) ? openstruct_to_hash(value) : value.is_a?(Array) ? array_to_hash(value) : value
      end
      hash
    end

    # Utility to convert array of OpenStruct to hash.
    def array_to_hash(array, hash= [])
      array.each do |item|
        x = item.is_a?(OpenStruct) ? openstruct_to_hash(item) : item.is_a?(Array) ? array_to_hash(item) : item
        hash << x
      end
      hash
    end
  end
end