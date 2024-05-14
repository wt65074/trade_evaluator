class AddTeamsToTrades < ActiveRecord::Migration[7.1]
  def change
    add_column :trades, :team_a, :string
    add_column :trades, :team_b, :string
  end
end
