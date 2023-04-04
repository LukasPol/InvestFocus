module Imports
  class SetParams
    attr_reader :params, :resource, :from

    def initialize(params, resource, from = :b3)
      @params = params
      @resource = resource
      @from = from
    end

    def self.call(params, from = :b3)
      new(params, from).call
    end

    def call
      return unless from == :b3

      from_b3
    end

    def from_b3
      new_params = {
        stock_code: set_stock_code,
        amount: params['Quantidade'],
        date: params['Data'],
        kind: 'inplit'
      }

      return new_params if resource == :inplit

      new_params[:value_unit] = format_value(params['Preço unitário'])
      new_params[:total_value] = format_value(params['Valor da Operação'])
      new_params[:date] = params['Data']

      new_params[:kind] = if resource == :proceed
                            params['Movimentação'] == 'Dividendo' ? 'dividends' : 'jcp'
                          else
                            params['Entrada/Saída'] == 'Credito' ? 'buy' : 'sale'
                          end

      new_params
    end

    def format_value(value)
      value.delete(' R$')
      value.gsub!(',', '.')
      value.to_f
    end

    def set_stock_code
      params['Produto'][0..4]
    end
  end
end
