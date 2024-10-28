#!/usr/bin/env sh

set -x

export ASAN_OPTIONS="allocator_may_return_null=1:detect_leaks=0:use_sigaltstack=0"
export LD_PRELOAD=$(bundle exec ruby -e 'require "ruzzy"; print Ruzzy::ASAN_PATH')

while true; do
  bundle exec oj-load.rb corpus

  exit_code=$?
  echo "Exit with exit code ${exit_code} at `date`"
  if [ $exit_code != 142 ]; then
      exit $exit_code
  fi
done
