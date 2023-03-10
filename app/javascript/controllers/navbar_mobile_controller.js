import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.showOrHide();
  }

  showOrHide() {
    $('.button-open').on('click', () => {
      this.handleClick()
    })
  }

  handleClick() {
    $('.navbar__items').toggleClass('show')
  }
}