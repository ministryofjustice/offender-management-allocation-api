#!/bin/bash
export RAILS_ENV=production
  echo "running migrate"
  bin/rake db:migrate
  echo "launching app"
bin/puma -b tcp://0.0.0.0:3000 -d -C config/puma_prod.rb
