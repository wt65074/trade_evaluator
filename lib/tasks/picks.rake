# frozen_string_literal: true
# typed: true

namespace :picks do
  desc 'Seed the initial three models. This is idempotent.'
  task :seed_picks, %i[season filepath] => :environment do |_, args|
    # found a uri with many models in a nice csv format
    year = args[:season].to_i
    file = args[:filepath]

    file_contents = URI.open(file, &:read)

    table = T.cast(CSV.parse(file_contents, converters: :numeric), T::Array[T::Array[T.untyped]])

    picks_to_upsert = table.map do |(pick, round, team)|
      {
        team:,
        round:,
        overall: pick,
        year:
      }
    end

    puts "Got #{picks_to_upsert.length} picks"

    DraftPick.upsert_all(picks_to_upsert, unique_by: %w[overall year])
    p "Created #{DraftPick.where(year:).count} model entries"
  end
end
