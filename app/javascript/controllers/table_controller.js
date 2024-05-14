import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row", "back", "front", "roundLabel", "form", "teamAPicks", "teamBPicks", "teamAScores", "teamBScores"]
  static values = {
    index: { type: Number, default: 0 }, models: { type: Array, default: [] }
  }

  initialize() {
    this.showCurrentTable()
    this.hideUselessButtons()
    this.greet()
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
    this.frontTarget.disabled = this.indexValue === this.maxIndexValue();
    this.backTarget.disabled = this.indexValue === 0;
  }

  maxIndexValue() {
    return Math.max(...this.rowTargets.map(element => Number(element.dataset.round))) - 1;
  }

  greet() {
    console.log("change data values")
    const formData = new FormData(this.formTarget);
    console.log(Array.from(formData.entries()))
    const picksA = formData.getAll('trade[team_a_picks][]')
    const picksB = formData.getAll('trade[team_b_picks][]')
    this.teamAPicksTarget.textContent = `${picksA}`
    this.teamBPicksTarget.textContent = `${picksB}`
    this.modelsValue.forEach(model => {
      console.log(this.modelsValue)
      console.log(model)
      const id = model.id;
      const modelScores = model.values;
      const targetScoreA = this.teamAScoresTargets.find(el => el.id == `score-A-${id}`);
      const targetScoreB = this.teamBScoresTargets.find(el => el.id == `score-B-${id}`);
      const valueA = picksA.map(pick => Number(model.values[pick])).reduce((acc, val) => acc + val, 0)
      const valueB = picksB.map(pick => Number(model.values[pick])).reduce((acc, val) => acc + val, 0)

      targetScoreA.textContent = Math.round(100 * valueA) / 100
      targetScoreB.textContent = Math.round(100 * valueB) / 100
      if (valueA > valueB) {
        targetScoreA.classList.add("bg-green-100")
        targetScoreB.classList.remove("bg-green-100")
      } else {
        targetScoreB.classList.add("bg-green-100")
        targetScoreA.classList.remove("bg-green-100")
      }
    })
  }
}
