import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['teamA', 'teamB'];

  static values = {
    imagePaths: { type: Object }
  };

  teamAChanged(team) {
    this.teamATargets.forEach(elem => elem.src = this.imagePathsValue[team])
  }
  teamBChanged(team) {
    this.teamBTargets.forEach(elem => elem.src = this.imagePathsValue[team])
  }
}
