import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const element = this.element

    setTimeout(function() {
      element.remove()
    }, 10000);
  }
}
