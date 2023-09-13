require "rails_helper"

RSpec.describe "Customer's Subscriptions Index API" do
  describe "GET /api/v1/customers/:id/subscriptions" do
    describe "Happy Path" do
      it "returns a list of all subscriptions for a customer" do
        customer_1 = create(:customer)
        customer_2 = create(:customer)

        tea_1 = create(:tea)
        tea_2 = create(:tea)
        tea_3 = create(:tea)

        subscription_1 = create(:subscription, customer: customer_1, tea: tea_1, status: 1)
        subscription_2 = create(:subscription, customer: customer_1, tea: tea_2, status: 0)
        subscription_3 = create(:subscription, customer: customer_1, tea: tea_3, status: 0)
        subscription_4 = create(:subscription, customer: customer_2, tea: tea_1, status: 0)
        subscription_5 = create(:subscription, customer: customer_2, tea: tea_2, status: 1)

        get "/api/v1/customers/#{customer_1.id}/subscriptions"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)

        expect(customer_1.subscriptions.count).to eq(3)
        expect(subscriptions[:data].count).to eq(3)

        subscriptions[:data].each do |subscription|
          expect(subscription).to have_key(:id)
          expect(subscription).to have_key(:type)
          expect(subscription[:type]).to eq("subscription")
          expect(subscription).to have_key(:attributes)
          expect(subscription[:attributes]).to have_key(:title)
          expect(subscription[:attributes]).to have_key(:price)
          expect(subscription[:attributes]).to have_key(:status)
          expect(subscription[:attributes]).to have_key(:frequency)
          expect(subscription[:attributes]).to have_key(:customer_id)
          expect(subscription[:attributes]).to have_key(:tea_id)
        end

        get "/api/v1/customers/#{customer_2.id}/subscriptions"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)

        expect(customer_2.subscriptions.count).to eq(2)
        expect(subscriptions[:data].count).to eq(2)
      end
    end

    describe "Sad Path" do
      it "returns a 404 if the customer is not found" do
        get "/api/v1/customers/1/subscriptions"

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response[:error]).to eq("Customer not found")
      end

      it "returns an empty array if the customer has no subscriptions" do
        customer = create(:customer)

        get "/api/v1/customers/#{customer.id}/subscriptions"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)

        expect(customer.subscriptions.count).to eq(0)
        expect(subscriptions[:data]).to eq([])
      end
    end
  end
end