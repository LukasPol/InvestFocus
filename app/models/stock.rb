class Stock < ApplicationRecord
  validates :code, presence: true
  validates :code, length: { in: 5..6 }
end
