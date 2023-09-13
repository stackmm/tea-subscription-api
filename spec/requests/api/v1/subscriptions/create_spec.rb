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

        sub_response = JSON.parse(response.body, symbolize_names: true)

        expect(sub_response[:data][:attributes][:title]).to eq(subscription_params[:title])
        expect(sub_response[:data][:attributes][:price]).to eq(subscription_params[:price].to_s)
        expect(sub_response[:data][:attributes][:status]).to eq("active")
        expect(sub_response[:data][:attributes][:frequency]).to eq(subscription_params[:frequency])
        expect(sub_response[:data][:attributes][:customer_id]).to eq(subscription_params[:customer_id])
        expect(sub_response[:data][:attributes][:tea_id]).to eq(subscription_params[:tea_id])
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

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Customer must exist")
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

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Tea must exist")
      end

      it "returns a 400 error if the title parameter is missing" do
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

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Title can't be blank")
      end

      it "returns a 400 error if the price parameter is missing" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          frequency: "Monthly",
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Price can't be blank and Price is not a number")
      end

      it "returns a 400 error if the frequency parameter is missing" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Frequency can't be blank and Frequency is not included in the list")
      end

      it "returns a 400 error if the customer_id parameter is missing" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          frequency: "Monthly",
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Customer must exist")
      end

      it "returns a 400 error if the tea_id parameter is missing" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          frequency: "Monthly",
          customer_id: customer.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Tea must exist")
      end

      it "returns a 400 error if the price is not a number" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: "ten dollars",
          frequency: "Monthly",
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Price is not a number")
      end

      it "returns a 400 error if the frequency is not valid" do
        customer = create(:customer)
        tea = create(:tea)

        subscription_params = {
          title: "My Monthly Tea Subscription",
          price: 10.00,
          frequency: "Daily",
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: subscription_params

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Frequency is not included in the list")
      end
    end
  end
end