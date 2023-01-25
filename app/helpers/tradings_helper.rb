module TradingsHelper
  def trading_locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.trading.kind_enum')
  end
end
