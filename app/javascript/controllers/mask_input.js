require("jquery-mask-plugin");

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.maskFields();
  }

  maskFields() {
    $('[data-masks-target="date"]').mask('00/00/0000');
  }
}