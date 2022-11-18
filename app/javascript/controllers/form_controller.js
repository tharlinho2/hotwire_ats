import { Controller } from "@hotwired/stimulus"
import  debounce from "lodash/debounce"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = [ 'form', 'button' ]

  connect() {
    this.submit = debounce(this.submit.bind(this), 200)
    this.buttonTarget.remove()
  }

  submit(){
    this.formTarget.requestSubmit()
  }
}
