import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rowA", "rowB", "back", "front", "roundLabel", "form", "teamAPicks", "teamBPicks", "teamAScores", "teamBScores", "teamA", "teamB", "checkboxA", "checkboxB"]
  static values = {
    index: { type: Number, default: 0 }, models: { type: Array, default: [] }, picksByTeam: { type: Object, default: {} },
    teamA: String,
    teamB: String
  }

  initialize() {
    this.showCurrentTable()
    this.greet()
  }
  next() {
    this.indexValue++
  }

  previous() {
    this.indexValue--
  }

  showCurrentTable() {
    console.log(this.rowATargets)
    this.rowATargets.forEach((element, index) => {
      element.hidden = this.teamATarget.value ? !this.picksByTeamValue[this.teamATarget.value].includes(Number(element.dataset.pick)) : true
    })
    this.rowBTargets.forEach((element, index) => {
      element.hidden = this.teamBTarget.value ? !this.picksByTeamValue[this.teamBTarget.value].includes(Number(element.dataset.pick)) : true
    })
  }

  teamAChanged() {
    this.checkboxATargets.forEach((element, index) => {
      element.checked = false
    })
    this.showCurrentTable()
  }

  teamBChanged() {
    this.checkboxBTargets.forEach((element, index) => {
      element.checked = false
    })
    this.showCurrentTable()
  }

  greet() {
    const formData = new FormData(this.formTarget);
    const picksA = formData.getAll('trade[team_a_picks][]')
    const picksB = formData.getAll('trade[team_b_picks][]')
    this.teamAPicksTarget.textContent = `${picksA}`
    this.teamBPicksTarget.textContent = `${picksB}`
    this.modelsValue.forEach(model => {
      const id = model.id;
      const modelScores = model.values;
      const targetScoreA = this.teamAScoresTargets.find(el => el.id == `score-A-${id}`);
      const targetScoreB = this.teamBScoresTargets.find(el => el.id == `score-B-${id}`);
      const valueA = picksA.map(pick => Number(model.values[pick])).reduce((acc, val) => acc + val, 0)
      const valueB = picksB.map(pick => Number(model.values[pick])).reduce((acc, val) => acc + val, 0)

      targetScoreA.textContent = `${valueB - valueA > 0 ? '+' : ''}${Math.round(100 * (valueB - valueA)) / 100}`
      targetScoreB.textContent = `${valueA - valueB > 0 ? '+' : ''}${Math.round(100 * (valueA - valueB)) / 100}`
      if (valueB > valueA) {
        targetScoreA.classList.add("bg-green-100")
        targetScoreB.classList.remove("bg-green-100")
      } else {
        targetScoreB.classList.add("bg-green-100")
        targetScoreA.classList.remove("bg-green-100")
      }
    })
  }
}
