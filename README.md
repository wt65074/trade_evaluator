# README

## Running
Im running on Ruby 3.3.1.

Create the DBs:
```rails db:migrate```

Seed the trade value models:
```rails models:seed_models```

Seed the draft schedule:
```bin/rails "picks:seed_picks[{year},{absolute path to csv}]"```