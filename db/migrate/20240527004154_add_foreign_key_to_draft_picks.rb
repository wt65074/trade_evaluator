class AddForeignKeyToDraftPicks < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :draft_picks, :teams, column: :team, primary_key: :shortname
  end
end
