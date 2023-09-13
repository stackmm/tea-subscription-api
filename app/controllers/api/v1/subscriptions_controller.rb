class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])

    if customer
      render json: SubscriptionSerializer.new(customer.subscriptions)
    else
      render json: {error: "Customer not found"}, status: 404
    end
  end
end