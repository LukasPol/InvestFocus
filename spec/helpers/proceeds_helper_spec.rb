require 'rails_helper'

RSpec.describe ProceedsHelper, type: :helper do
  context '.proceed_locale_kind' do
    it { expect(helper.proceed_locale_kind('dividends')).to eq('Dividendos') }
    it { expect(helper.proceed_locale_kind('jcp')).to eq('JCP') }
  end

  context '.proceed_kind_enum' do
    it { expect(helper.proceed_kind_enum).to eq([%w[Dividendos dividends], %w[JCP jcp]]) }
  end
end
