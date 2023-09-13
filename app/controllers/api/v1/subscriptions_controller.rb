class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
  end

  def create
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  private
  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end