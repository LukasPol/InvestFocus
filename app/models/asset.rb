class Asset < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  has_many :tradings, dependent: :restrict_with_error

  validates :stock, :user, :amount, :average_price, :total_invested, presence: true
  validates :stock_id, uniqueness: { scope: [:user_id] }

  validates :average_price, :amount, :total_invested, numericality: { greater_than_or_equal_to: 0 }
end
