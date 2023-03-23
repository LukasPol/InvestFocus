import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.onInput();
  }

  onInput() {
    const $amount = $('.amount')
    const $valueUnit = $('.value_unit')

    $amount.on('input', () => {
      this.calculateTotalValue($amount, $valueUnit)
    })

    $valueUnit.on('input', () => {
      this.calculateTotalValue($amount, $valueUnit)
    })
  }

  calculateTotalValue(amount, valueUnit) {
    const totalValue = parseInt(amount.val()) * parseInt(valueUnit.val()) || 0
    $('.total_value').val(totalValue)
  }
}
