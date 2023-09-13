class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title, :price, :status, :frequency
  validates_numericality_of :price
  validates :frequency, inclusion: { in: ["Yearly", "Monthly", "Weekly"] }

  enum status: [:active, :cancelled]
end
