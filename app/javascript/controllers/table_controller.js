import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "teamA", "teamB"]
  static values = {
    index: { type: Number, default: 0 }, models: { type: Array, default: [] }, picksByTeam: { type: Object, default: {} },
    teamA: String,
    teamB: String
  }

  static outlets = ['results', 'picks'];

  connect() {
    this.updateTeams()
    this.updatePicks()
  }

  teamAChanged() {
    this.updateTeams()
  }

  teamBChanged() {
    this.updateTeams()
  }

  updatePicks() {
    const formData = new FormData(this.formTarget);
    const picksA = formData.getAll('trade[team_a_picks][]')
    const picksB = formData.getAll('trade[team_b_picks][]')
    console.log(picksA, picksB)
    this.resultsOutlet.picksUpdated(picksA, picksB)
  }

  updateTeams() {
    const teamA = this.teamATarget.value
    const teamB = this.teamBTarget.value
    const teamAPicks = teamA ? this.picksByTeamValue[teamA] : []
    const teamBPicks = teamB ? this.picksByTeamValue[teamB] : []
    this.picksOutlets.forEach(picksController => {
      picksController.showRows(
        picksController.element.id == "picks-team-a" ? teamAPicks : teamBPicks)
    })
  }
}
