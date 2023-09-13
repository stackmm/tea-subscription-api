class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions)
  end

  def create
    subscription = Subscription.new(subscription_params)

    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: {error: subscription.errors.full_messages.to_sentence}, status: 400
    end
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.cancelled!

    render json: SubscriptionSerializer.new(subscription), status: 200
  end

  private
  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end