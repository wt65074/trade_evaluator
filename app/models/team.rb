class Team < ApplicationRecord
  has_many :draft_pick, foreign_key: 'team'
  self.primary_key = :shortname

  def image_path
    "logos/#{shortname}.png"
  end
end
