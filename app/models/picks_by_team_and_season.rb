class PicksByTeamAndSeason < ApplicationRecord
  serialize :picks, coder: JSON, type: Array
end
