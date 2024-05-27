class AddForeignKeyToTrades < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :trades, :teams, column: :team_a, primary_key: :shortname
    add_foreign_key :trades, :teams, column: :team_b, primary_key: :shortname
  end
end
