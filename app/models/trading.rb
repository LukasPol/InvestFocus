class Trading < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  belongs_to :asset

  enum kind: { buy: 0, sell: 1 }

  validates :amount, :value_unit, :total_value, :date, :kind, :asset, :stock, :user, presence: true

  validates :amount, :value_unit, :total_value, numericality: { greater_than_or_equal_to: 0 }

  validate do
    errors.add(:date, I18n.t(:after_today, scope: 'errors.messages')) if date && date > Time.zone.today
  end
end
