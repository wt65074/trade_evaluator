import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['teamA', 'teamB'];

  static values = {
    imagePaths: { type: Object }
  };

  teamAChanged(team) {
    this.teamATargets.forEach(elem => this.setIconForTarget(team, elem));
  }
  teamBChanged(team) {
    this.teamBTargets.forEach(elem => this.setIconForTarget(team, elem));
  }

  setIconForTarget(team, target) {
    console.log(`team: ${team.length} ${team ?? 'empty'} temp`)
    console.log(this.imagePathsValue)
    target.src = this.imagePathsValue[team ? team : 'empty']
  }
}
