#!/bin/bash

rm ~/Dev/spaceman/config/secrets.yml
echo "production:" > ~/Dev/spaceman/config/secrets.yml
echo "  secret_key_base: `bundle exec rake secret`" >> ~/Dev/spaceman/config/secrets.yml

echo "Done"
