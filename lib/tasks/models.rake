# frozen_string_literal: true
# typed: true

namespace :models do
  desc 'Seed the initial three models. This is idempotent.'
  task seed_models: :environment do
    # found a uri with many models in a nice csv format
    file = 'https://raw.githubusercontent.com/leesharpe/nfldata/master/data/draft_values.csv'

    file_contents = URI.open(file, &:read)
    Rails.logger.debug(file_contents)

    table = T.cast(CSV.parse(file_contents, converters: :numeric), T::Array[T::Array[T.untyped]])
    models = T.must(table.shift).drop(1) # header row, drop the first column name which be irrelevant

    # first create our models
    models_to_create = models.map { |model_name| { name: model_name } }

    # upsert new models, unique on name so that you cannot create new models of the same name
    ValueModel.upsert_all(models_to_create, unique_by: 'name')
    # ids will be ordered the same as the table rows
    model_ids = models.map { |name| ValueModel.where('name = ?', name).take }.map(&:id)
    p "Created #{ValueModel.count} models"

    model_picks_to_upsert = table.flat_map do |l|
      model_ids.each_with_index.map do |model_id, index|
        {
          value_model_id: model_id,
          pick: l[0],
          value: l[index + 1]
        }
      end
    end
    ValueModelPick.upsert_all(model_picks_to_upsert, unique_by: %w[value_model_id pick])
    p "Created #{ValueModelPick.count} model entries"
  end
end
