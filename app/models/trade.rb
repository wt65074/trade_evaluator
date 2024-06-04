class Trade < ApplicationRecord
  serialize :team_a_picks, coder: JSON, type: Array
  serialize :team_b_picks, coder: JSON, type: Array
  validates_associated :team_a
  validates_associated :team_b
  belongs_to :team_a, class_name: 'Team', foreign_key: 'team_a', primary_key: 'shortname'
  belongs_to :team_b, class_name: 'Team', foreign_key: 'team_b', primary_key: 'shortname'

  def all_model_scores
    all_models = ValueModel.all_models_cached
    all_models.map { |m| [m.id, m.score(team_a_picks, team_b_picks)] }.to_h
  end

  def team_a_shortname
    team_a&.shortname
  end

  def team_b_shortname
    team_b&.shortname
  end
end
