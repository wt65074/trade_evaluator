import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "teamA", "teamB"]
  static values = {
    index: { type: Number, default: 0 }, models: { type: Array, default: [] }, picksByTeam: { type: Object, default: {} },
    teamA: String,
    teamB: String
  }

  static outlets = ['results', 'picks', 'image-provider'];

  connect() {
    this.updateTeams()
    this.updatePicks()
  }

  teamAChanged() {
    this.updateTeams()
    const outlet = this.picksOutlets.find(outlet => outlet.element.id == 'picks-team-a')
    this.clearPicks(outlet)
  }

  teamBChanged() {
    this.updateTeams()
    const outlet = this.picksOutlets.find(outlet => outlet.element.id == 'picks-team-b')
    this.clearPicks(outlet)
  }

  clearPicks(outlet) {
    outlet.clearSelections()
  }

  updatePicks() {
    const formData = new FormData(this.formTarget);
    const picksA = formData.getAll('trade[team_a_picks][]')
    const picksB = formData.getAll('trade[team_b_picks][]')
    this.resultsOutlet.picksUpdated(picksA, picksB)
  }

  updateTeams() {
    const teamA = this.teamATarget.value
    const teamB = this.teamBTarget.value
    const teamAPicks = teamA ? this.picksByTeamValue[teamA] : []
    const teamBPicks = teamB ? this.picksByTeamValue[teamB] : []
    this.imageProviderOutlet.teamAChanged(this.teamATarget.value)
    this.imageProviderOutlet.teamBChanged(this.teamBTarget.value)
    this.picksOutlets.forEach(picksController => {
      picksController.showRows(
        picksController.element.id == "picks-team-a" ? teamAPicks : teamBPicks)
    })
  }
}
