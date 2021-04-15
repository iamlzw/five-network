#!/bin/sh

docker-compose -f docker-compose-e2e.yaml down

docker volume prune
