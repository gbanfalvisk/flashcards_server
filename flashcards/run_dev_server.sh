#!/bin/bash

echo "Migrating"
bin/rake db:migrate

echo "Starting server"
bin/rails server
