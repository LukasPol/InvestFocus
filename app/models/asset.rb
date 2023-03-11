class Asset < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  has_many :tradings, dependent: :restrict_with_error

  validates :stock, :user, :amount, :average_price, :total_invested, presence: true
  validates :stock_id, uniqueness: { scope: [:user_id] }

  validates :average_price, :amount, :total_invested, numericality: { greater_than_or_equal_to: 0 }

  broadcasts_to ->(asset) { [asset.user, 'assets'] }, inserts_by: :prepend

  def self.ransackable_attributes(_auth_object = nil)
    []
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[stock]
  end
end
