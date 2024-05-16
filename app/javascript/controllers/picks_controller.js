import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row", "checkbox"];

  teamChanged(picksToShow) {
    console.log(picksToShow)
    this.clearSelections()
    this.showRows(picksToShow)
  }

  clearSelections() {
    this.checkboxTargets.forEach((element, _) => {
      element.checked = false
    })
  }

  showRows(picksToShow) {
    this.rowTargets.forEach((element, _) => {
      element.hidden = !picksToShow.includes(Number(element.dataset.pick));
    }
    )
  }
}