# typed: true
class CreateValueModels < ActiveRecord::Migration[7.1]
  def change
    create_table :value_models do |t|
      t.string :name 
      t.index :name, unique: true
      t.timestamps
    end
  end
end
