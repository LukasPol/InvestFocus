class Trading < ApplicationRecord
  attr_accessor :stock_code

  belongs_to :user
  belongs_to :stock
  belongs_to :asset

  enum kind: { buy: 0, sale: 1, inplit: 2 }

  before_validation :set_stock, if: -> { stock.nil? && stock_code.present? }
  before_validation :set_asset

  validates :amount, :value_unit, :total_value, :date, :kind, :asset, :stock, :user, presence: true

  validates :amount, :value_unit, :total_value, numericality: { greater_than_or_equal_to: 0 }

  validate do
    errors.add(:date, I18n.t(:after_today, scope: 'errors.messages')) if date && date > Time.zone.today
  end

  after_create do
    Assets::Updater.call(asset, self)
  end

  scope :buy, -> { where(kind: 'buy') }
  scope :sale, -> { where(kind: 'sale') }
  scope :inplit, -> { where(kind: 'inplit') }

  private

  def set_stock
    stock = Stock.find_or_create_by(code: stock_code)

    self.stock_id = stock.id
  end

  def set_asset
    asset = Asset.find_or_create_by(stock:, user:)

    self.asset_id = asset.id
  end
end
