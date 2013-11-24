#!/bin/sh

export PATH=$PATH:/usr/local/phpenv/bin
eval "$(/usr/local/phpenv/bin/phpenv init -)"
phpenv rehash 2>/dev/null