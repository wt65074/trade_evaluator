class CreatePicksByTeamAndSeasons < ActiveRecord::Migration[7.1]
  def change
    create_table :picks_by_team_and_seasons do |t|
      t.string :team
      t.text :picks
      t.integer :season

      t.timestamps
      t.index %i[season team], unique: true
    end
  end
end
