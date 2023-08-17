#!/bin/sh

# Reference: Rails server is still running in a new opened docker container
# https://stackoverflow.com/a/38732187/1935918
set -e
if [ -f /app/tmp/pids/server.pid ]; then
  # Remove previous server PID file
  rm /app/tmp/pids/server.pid
fi

bundle exec rails db:environment:set RAILS_ENV=production
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup
bundle exec rails db:populate_fake_data
exec bundle exec "$@"