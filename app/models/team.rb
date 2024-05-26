class Team < ApplicationRecord
  has_many :draft_pick, foreign_key: 'team'
  self.primary_key = :shortname
end
