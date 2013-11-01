#!/bin/sh

export PATH=$PATH:/home/vagrant/.phpenv/bin
eval "$(/home/vagrant/.phpenv/bin/phpenv init -)"
phpenv rehash 2>/dev/null