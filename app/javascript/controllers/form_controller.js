import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]
  greet() {
    console.log("Hello, stimulus!", this.element)
    const formData = new FormData(this.formTarget);
    const picks = formData.get('picks')
    console.log(picks);
  }
}
