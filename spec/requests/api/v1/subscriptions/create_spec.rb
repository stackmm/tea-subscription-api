require "rails_helper"

RSpec.describe "Create Subscription API" do
  describe "POST /api/v1/subscriptions" do
    describe "Happy Path" do
      it "creates a new subscription" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          frequency: "Monthly",
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to be_successful
        expect(response.status).to eq(201)

        subscription = JSON.parse(response.body, symbolize_names: true)

        expect(subscription[:data][:attributes][:title]).to eq(subscription_params[:title])
        expect(subscription[:data][:attributes][:price]).to eq(subscription_params[:price])
        expect(subscription[:data][:attributes][:status]).to eq(subscription_params[:status])
        expect(subscription[:data][:attributes][:frequency]).to eq(subscription_params[:frequency])
        expect(subscription[:data][:attributes][:customer_id]).to eq(subscription_params[:customer_id])
        expect(subscription[:data][:attributes][:tea_id]).to eq(subscription_params[:tea_id])
      end
    end

    describe "Sad Path" do

    end
  end
end