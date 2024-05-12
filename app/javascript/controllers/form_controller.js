import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]
  greet() {
    console.log("Hello, stimulus!", this.element)
    const formData = new FormData(this.formTarget);
    console.log(formData);
    const object = {};
    formData.forEach((value, key) => object[key] = value);
    const json = JSON.stringify(object);
    console.log(json)
  }
}
