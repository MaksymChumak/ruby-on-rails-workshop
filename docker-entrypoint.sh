#!/bin/bash
set -e
rm -f /home/workshop/tmp/pids/server.pid

# always reset the database(repopulate images) to support disabled synchronization for /storage folder
# to improve performance for running tests inside the container

# bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:reset
bundle exec rake db:reset
bundle exec rails s -b 0.0.0.0 -p 3000