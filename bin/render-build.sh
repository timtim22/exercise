#!/usr/bin/env bash
# exit on error
set -o errexit

echo "RAILS_MASTER_KEY: $RAILS_MASTER_KEY"
echo "DATABASE_URL: $DATABASE_URL"

bundle install
bundle exec rake assets:precompile --trace
bundle exec rake assets:clean --trace
bundle exec rake db:migrate --trace