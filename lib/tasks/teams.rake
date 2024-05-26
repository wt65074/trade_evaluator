namespace :teams do
  desc 'Seed the teams required in the models'
  task :seed_teams, [:filepath] => :environment do |_, args|
    file = args[:filepath]
    file_contents = URI.open(file, &:read)

    table = T.cast(CSV.parse(file_contents, converters: :numeric), T::Array[T::Array[T.untyped]])

    teams_to_upsert = table.map do |(name, shortname)|
      {
        name:,
        shortname:
      }
    end

    puts "Got #{teams_to_upsert.length} teams"

    Team.upsert_all(teams_to_upsert, unique_by: 'shortname')
    p "Created #{Team.all.count} model entries"
  end
end
