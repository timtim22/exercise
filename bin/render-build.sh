#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install --check-files
bundle exec rake assets:precompile --trace
bundle exec rake assets:clean --trace
bundle exec rake db:migrate --trace