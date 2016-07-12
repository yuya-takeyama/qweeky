#!/bin/sh
cd server && bundle exec rake db:test:prepare && bundle exec rake
exit $!
