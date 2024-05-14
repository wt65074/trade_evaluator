class Trade < ApplicationRecord
  serialize :team_a_picks, coder: JSON, type: Array
  serialize :team_b_picks, coder: JSON, type: Array

  def all_model_scores
    all_models = ValueModel.all
    all_models.map { |m| [m.id, m.score(team_a_picks, team_b_picks)] }.to_h
  end
end
