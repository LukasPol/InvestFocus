class Proceed < ApplicationRecord
  attr_accessor :stock_code

  belongs_to :user
  belongs_to :asset
  belongs_to :stock

  enum kind: { dividends: 0, jcp: 1 }

  before_validation :set_stock, if: -> { stock_code.present? }
  before_validation :set_asset

  validates :amount, :value_unit, :total_value, :date, :kind, :asset, :stock, :user, presence: true

  validates :amount, :value_unit, :total_value, numericality: { greater_than_or_equal_to: 0 }

  validate do
    errors.add(:date, I18n.t(:after_today, scope: 'errors.messages')) if date && date > Time.zone.today
  end

  broadcasts_to ->(proceed) { [proceed.user, 'proceeds'] }, inserts_by: :prepend

  def set_stock
    stock = user&.stocks&.find_by(code: stock_code)

    if stock.nil?
      errors.add(:stock_code, I18n.t(:dont_have, scope: 'activerecord.errors.models.proceeds.attributes.stock'))
      return false
    end

    self.stock_id = stock.id
  end

  def set_asset
    asset = user&.assets&.find_by(stock:)

    if asset.nil?
      errors.add(:asset, I18n.t(:dont_have, scope: 'activerecord.errors.models.proceeds.attributes.asset'))
      return false
    end

    self.asset_id = asset.id
  end
end
