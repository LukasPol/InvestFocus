module TradingsHelper
  def trading_locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.trading.kind_enum')
  end

  def trading_kind_enum_search
    Trading.kinds.map do |key, value|
      [trading_locale_kind(key), value]
    end
  end
end
