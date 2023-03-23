module ProceedsHelper
  def proceed_locale_kind(kind)
    I18n.t(kind, scope: 'activerecord.attributes.proceed.kind_enum')
  end

  def proceed_kind_enum
    Proceed.kinds.map do |key, _value|
      [proceed_locale_kind(key), key]
    end
  end

  def stock_select
    current_user.stocks.map do |stock|
      [stock.code, stock.id]
    end
  end
end
