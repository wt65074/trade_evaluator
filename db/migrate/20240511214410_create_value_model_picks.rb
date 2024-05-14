class CreateValueModelPicks < ActiveRecord::Migration[7.1]
  def change
    create_table :value_model_picks do |t|
      t.references :value_model, null: false, foreign_key: true
      t.integer :pick
      t.decimal :value
      t.index %i[pick value_model_id], unique: true

      t.timestamps
    end
  end
end
