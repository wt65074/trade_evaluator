class Trade < ApplicationRecord
  serialize :team_a_picks, coder: JSON, type: Array
  serialize :team_b_picks, coder: JSON, type: Array
  validates :team_a, :team_b, presence: true
  belongs_to :team_a, class_name: 'Team', foreign_key: 'team_a', primary_key: 'shortname'
  belongs_to :team_b, class_name: 'Team', foreign_key: 'team_b', primary_key: 'shortname'

  def all_model_scores
    all_models = ValueModel.all_models_cached
    all_models.map { |m| [m.id, m.score(team_a_picks, team_b_picks)] }.to_h
  end
end
