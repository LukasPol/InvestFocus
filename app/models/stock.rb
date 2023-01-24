class Stock < ApplicationRecord
  has_many :assets, dependent: :restrict_with_error

  validates :code, presence: true
  validates :code, length: { in: 5..6 }
end
