#!/bin/bash
echo "Running migrate"
bundle exec rake db:create
bundle exec rake db:migrate

echo "Running app"
bundle exec puma -p 3000 -C config/puma_prod.rb
