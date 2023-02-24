class Stock < ApplicationRecord
  has_many :assets, dependent: :restrict_with_error
  has_many :tradings, dependent: :restrict_with_error

  validates :code, presence: true
  validates :code, length: { in: 5..6 }
  validates :code, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[code]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[assets tradings]
  end
end
