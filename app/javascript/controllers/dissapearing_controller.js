import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { refreshInterval: { type: Number, default: 3000 } }
  static targets = ['main']

  startRefreshing() {
    setTimeout(() => {
      if (this.hasMainTarget) {
        this.mainTarget.hidden = true
      }
    }, this.refreshIntervalValue)
  }

  mainTargetConnected(element) {
    console.log(this)
    console.log(element)
    console.log(this.hasMainTarget)
    console.log(this.mainTarget)
    if (this.hasMainTarget) {
      console.log("refreshing")
      this.startRefreshing()
    }
  }

  connect() {
    console.log("connect")
  }
}
