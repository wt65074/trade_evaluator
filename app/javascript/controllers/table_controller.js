import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row", "back", "front", "roundLabel", "form", "teamAPicks"]
  static values = { index: { type: Number, default: 0 } }

  initialize() {
    this.showCurrentTable()
    this.hideUselessButtons()
  }
  next() {
    this.indexValue++
  }

  previous() {
    this.indexValue--
  }

  indexValueChanged() {
    this.showCurrentTable()
    this.hideUselessButtons()
  }

  showCurrentTable() {
    this.rowTargets.forEach((element, index) => {
      element.hidden = Number(element.dataset.round) !== this.indexValue
    })
    this.hideUselessButtons()
    this.roundLabelTarget.textContent = `Round ${this.indexValue + 1}`
  }

  hideUselessButtons() {
    console.log(this.maxIndexValue());
    this.frontTarget.disabled = this.indexValue === this.maxIndexValue();
    this.backTarget.disabled = this.indexValue === 0;
  }

  maxIndexValue() {
    return Math.max(...this.rowTargets.map(element => Number(element.dataset.round))) - 1;
  }

  greet() {
    console.log("Hello, stimulus!", this.element)
    const formData = new FormData(this.formTarget);
    console.log(Array.from(formData.entries()));
    const object = {};
    const body = Array.from(formData.entries()).map(([key, value]) => key).join(', ')
    this.teamAPicksTarget.textContent = `${body}`
  }
}
