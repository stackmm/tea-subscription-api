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
        expect(subscription[:data][:attributes][:price]).to eq(subscription_params[:price].to_s)
        expect(subscription[:data][:attributes][:status]).to eq("active")
        expect(subscription[:data][:attributes][:frequency]).to eq(subscription_params[:frequency])
        expect(subscription[:data][:attributes][:customer_id]).to eq(subscription_params[:customer_id])
        expect(subscription[:data][:attributes][:tea_id]).to eq(subscription_params[:tea_id])
      end
    end

    describe "Sad Path" do
      it "returns a 400 error if the customer is not found" do
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          frequency: "Monthly",
          customer_id: 1,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response_json[:error]).to eq("Customer must exist")
      end

      it "returns a 400 error if the tea is not found" do
        customer = create(:customer)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          frequency: "Monthly",
          customer_id: customer.id,
          tea_id: 1
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response_json[:error]).to eq("Tea must exist")
      end

      it "returns a 400 error if any parameter is missing" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          price: 10.00,
          frequency: "Monthly",
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response_json[:error]).to eq("Title can't be blank")
      end

      it "returns a 400 error if the price is not a number" do

      end

      it "returns a 4004 error if the frequency is not valid" do

      end

      it "returns a 400 error if the customer already has a subscription to that tea" do

      end
    end
  end
end