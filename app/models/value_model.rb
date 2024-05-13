# typed: true

require 'csv'
class ValueModel < ApplicationRecord
  has_many :value_model_pick, dependent: :delete_all

  validates :name, uniqueness: { message: 'must be unique' }

  def to_csv
    CSV.generate do |csv|
      column_names = %w[pick value]
      csv << column_names
      value_model_pick.each do |pick|
        csv << pick.attributes.values_at(*column_names)
      end
    end
  end
end
