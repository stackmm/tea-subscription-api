require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should belong_to :tea }
    it { should belong_to :customer }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should validate_numericality_of :price }
    it { should validate_inclusion_of(:frequency).in_array(["Yearly", "Monthly", "Weekly"]) }
  end
end
