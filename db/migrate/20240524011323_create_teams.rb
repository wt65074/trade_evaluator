class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :shortname, null: false
      t.string :name, null: false

      t.timestamps

      t.index :shortname, unique: true
    end
  end
end
