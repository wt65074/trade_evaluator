class CreateTrades < ActiveRecord::Migration[7.1]
  def change
    create_table :trades do |t|
      t.text :team_a_picks
      t.text :team_b_picks

      t.timestamps
    end
  end
end
