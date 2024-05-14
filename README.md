# README

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
## Create A Trade

https://github.com/wt65074/trade_evaluator/assets/6855641/5dec9a1e-5502-4ef2-8862-74ef121776b8

## Update Models, Save Trades, Load Trades

https://github.com/wt65074/trade_evaluator/assets/6855641/e7241a30-bce3-4f09-be5d-4b40c9f07018

