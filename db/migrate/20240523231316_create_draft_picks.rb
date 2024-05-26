class CreateDraftPicks < ActiveRecord::Migration[7.1]
  def change
    create_table :draft_picks do |t|
      t.integer :round
      t.integer :overall
      t.integer :year
      t.string :team

      t.timestamps
      t.index %i[overall year], unique: true
      t.index :team
    end
  end
end
