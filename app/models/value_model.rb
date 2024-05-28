# typed: true

require 'csv'
class ValueModel < ApplicationRecord
  has_many :value_model_pick, dependent: :delete_all

  validates :name, uniqueness: { message: 'must be unique' }

  @cached_models_as_map = {}

  def to_csv
    CSV.generate do |csv|
      column_names = %w[pick value]
      csv << column_names
      value_model_pick.each do |pick|
        csv << pick.attributes.values_at(*column_names)
      end
    end
  end

  def score(picks_a, picks_b)
    this_as_map = to_map

    picks_a_score = picks_a.map { |pick| this_as_map[pick] }.sum
    picks_b_score = picks_b.map { |pick| this_as_map[pick] }.sum

    [picks_a_score, picks_b_score]
  end

  def to_map
    puts to_map_impl, self.class.cached_models_as_map
    self.class.cached_models_as_map[id] ||= to_map_impl
  end

  class << self
    attr_reader :cached_models_as_map
  end

  def self.all_models_cached
    @all_models_cached ||= all
  end

  private

  def to_map_impl
    value_model_pick.map { |x| [x.pick, x.value] }.to_h
  end
end
