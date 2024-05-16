import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["teamAPicks", "teamBPicks", "teamAScore", "teamBScore"];

  static values = {
    models: { type: Array, default: [] }
  };

  picksUpdated(teamAPicks, teamBPicks) {
    this.updateModelScores(teamAPicks, teamBPicks)
    this.updatePicksLabels(teamAPicks, teamBPicks)
  }

  updatePicksLabels(teamAPicks, teamBPicks) {
    this.teamAPicksTarget.textContent = `${teamAPicks.join(",")}`
    this.teamBPicksTarget.textContent = `${teamBPicks.join(",")}`
  }

  updateModelScores(teamAPicks, teamBPicks) {
    const modelScores = new Map(this.modelsValue.map(model => {
      const id = model.id;
      const modelScores = model.values;

      const valueA = teamAPicks.map(pick => Number(model.values[pick])).reduce((acc, val) => acc + val, 0)
      const valueB = teamBPicks.map(pick => Number(model.values[pick])).reduce((acc, val) => acc + val, 0)

      return [id,
        Math.round(100 * (valueB - valueA)) / 100
      ]
    }))
    console.log(modelScores)

    this.teamAScoreTargets.forEach((elem, _) => {
      const modelId = Number(elem.dataset.modelId);
      const modelScore = modelScores.get(modelId);
      elem.textContent = `${modelScore > 0 ? '+' : ''}${modelScore}`
      if (modelScore < 0) {
        elem.classList.add("bg-green-100")
      } else {
        elem.classList.remove("bg-green-100")
      }
    })

    this.teamBScoreTargets.forEach((elem, _) => {
      const modelId = Number(elem.dataset.modelId);
      const modelScore = modelScores.get(modelId);
      elem.textContent = `${modelScore < 0 ? '-' : ''}${modelScore}`
      if (modelScore > 0) {
        elem.classList.add("bg-green-100")
      } else {
        elem.classList.remove("bg-green-100")
      }
    })


  }

}