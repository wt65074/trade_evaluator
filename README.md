# README

## Updates
This was a first rails project for me so theres a number of things in here I am hoping to refactor
### Technical
- [x] refactor stimulus controllers to seperate responsibilies
- [ ] refactor erb files to reduce duplication
- [ ] fix overfetching of data during trade display using memoization or caching
- [ ] update data model for picks to be more robust and to handle the comp picks situation
- [ ] update the team picks model so that it can take multiple seasons
- [ ] remove redundant routing
- [ ] form validation messages!

### UX
- [ ] Allow users to upload files to create a new season
- [ ] improve the clarity of winner/loser scores
- [ ] improve team name to be short form and include iocns

## Running
Im running on Ruby 3.3.1.

Create the DBs:
```rails db:migrate```

Seed the trade value models:
```rails models:seed_models```

Seed the draft schedule:
```bin/rails "picks:seed_picks[{year},{absolute path to csv}]"```

Run the server:
```rails server```

# Demo
The demo video has a messed up table showing the round and overall. Fixed that an will fix videos.
## Create A Trade

https://github.com/wt65074/trade_evaluator/assets/6855641/5dec9a1e-5502-4ef2-8862-74ef121776b8

## Update Models, Save Trades, Load Trades

https://github.com/wt65074/trade_evaluator/assets/6855641/e7241a30-bce3-4f09-be5d-4b40c9f07018

