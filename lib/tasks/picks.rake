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

    picks_by_team = table.each_with_object({}) do |(num, str), acc|
      acc[str] ||= []
      acc[str] << num
    end

    puts "Got #{picks_by_team.keys.length} teams"

    picks_to_upsert = picks_by_team.to_a.map do |key_and_v|
      {
        team: key_and_v[0],
        picks: key_and_v[1],
        season: year
      }
    end

    PicksByTeamAndSeason.upsert_all(picks_to_upsert, unique_by: %w[team season])
    p "Created #{PicksByTeamAndSeason.where(season: year).count} model entries"
  end
end
