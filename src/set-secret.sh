#!/bin/bash

if [ -e ~/Dev/spaceman/config/secrets.yml ]; then
	rm ~/Dev/spaceman/config/secrets.yml
fi

key=`ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"`

echo "production:" > ~/Dev/spaceman/config/secrets.yml
echo "  secret_key_base: ${key}" >> ~/Dev/spaceman/config/secrets.yml

echo "Done"
