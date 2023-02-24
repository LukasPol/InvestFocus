require 'rails_helper'

RSpec.describe TradingsHelper, type: :helper do
  context '.trading_locale_kind' do
    it { expect(helper.trading_locale_kind('buy')).to eq('Compra') }
    it { expect(helper.trading_locale_kind('sale')).to eq('Venda') }
    it { expect(helper.trading_locale_kind('inplit')).to eq('Grupamento') }
  end

  context '.trading_kind_enum_search' do
    it { expect(helper.trading_kind_enum_search).to eq([['Compra', 0], ['Venda', 1], ['Grupamento', 2]]) }
  end
end
