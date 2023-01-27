module Assets
  class Updater
    attr_accessor :asset, :trading

    def initialize(asset, trading)
      @asset = asset
      @trading = trading
    end

    def self.call(asset, trading)
      new(asset, trading).call
    end

    def call
      if trading.kind == 'buy'
        calculate_buy
      else
        calculate_sale
      end

      asset.save
    end

    private

    def calculate_buy
      asset.amount += trading.amount
      asset.total_invested += trading.total_value

      asset.average_price = (asset.total_invested / asset.amount).round(2)
    end

    def calculate_sale
      asset.amount -= trading.amount

      if asset.amount.negative? || asset.amount.zero?
        asset.amount = 0
        asset.average_price = 0
        asset.total_invested = 0
      else
        asset.total_invested = (asset.average_price * asset.amount).round(2)
      end
    end
  end
end
