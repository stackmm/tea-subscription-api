require "rails_helper"

RSpec.describe "Destroy Subscription API" do
  describe "DELETE /api/v1/subscriptions/:id" do
    describe "Happy Path" do
      it "deletes a subscription" do
        customer = create(:customer)
        tea = create(:tea)
        subscription = create(:subscription, customer: customer, tea: tea, status: 0)

        expect(subscription.status).to eq("active")

        delete "/api/v1/subscriptions/#{subscription.id}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscription = Subscription.find_by(id: subscription.id)

        expect(subscription.status).to eq("cancelled")

        sub_response = JSON.parse(response.body, symbolize_names: true)

        expect(sub_response[:data][:attributes][:status]).to eq("cancelled")
        expect(sub_response[:data][:attributes][:title]).to eq(subscription.title)
        expect(sub_response[:data][:attributes][:price]).to eq(subscription.price.to_s)
        expect(sub_response[:data][:attributes][:frequency]).to eq(subscription.frequency)
        expect(sub_response[:data][:attributes][:customer_id]).to eq(subscription.customer_id)
        expect(sub_response[:data][:attributes][:tea_id]).to eq(subscription.tea_id)
      end
    end

    describe "Sad Path" do
      it "returns a 404 if the subscription is not found" do
        delete "/api/v1/subscriptions/1"

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response[:error]).to eq("Customer not found")
      end

      it "returns a 404 if the subscription is already cancelled" do
        customer = create(:customer)
        tea = create(:tea)
        subscription = create(:subscription, customer: customer, tea: tea, status: 1)

        delete "/api/v1/subscriptions/#{subscription.id}"

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response[:error]).to eq("Subscription is already cancelled")
      end
    end
  end
end