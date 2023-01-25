require 'rails_helper'

RSpec.describe TradingsHelper, type: :helper do
  context '.trading_locale_kind' do
    it { expect(helper.trading_locale_kind('buy')).to eq('Compra') }
    it { expect(helper.trading_locale_kind('sell')).to eq('Venda') }
  end
end
