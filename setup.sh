#!/bin/sh

set -x

sudo apt install clang libclang-rt-19-dev

bundle config set path vendor/bundle

echo 'Install without target'

bundle config set without 'target'
MAKE="make --environment-overrides V=1" \
CC="/usr/bin/clang" \
CXX="/usr/bin/clang++" \
LDSHARED="/usr/bin/clang -shared" \
LDSHAREDXX="/usr/bin/clang++ -shared" \
  bundle install --without target

echo 'Install target'

MAKE="make --environment-overrides V=1" \
CC="/usr/bin/clang" \
CXX="/usr/bin/clang++" \
LDSHARED="/usr/bin/clang -shared" \
LDSHAREDXX="/usr/bin/clang++ -shared" \
CFLAGS="-fsanitize=address,fuzzer-no-link -fno-omit-frame-pointer -fno-common -fPIC -g" \
CXXFLAGS="-fsanitize=address,fuzzer-no-link -fno-omit-frame-pointer -fno-common -fPIC -g" \
  bundle install --with target
