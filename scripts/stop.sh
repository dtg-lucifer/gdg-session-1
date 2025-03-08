#!/bin/bash

echo "Stopping Blue and Green containers..."

# Stop the containers (ignore errors if they are not running)
sudo docker stop blue_container green_container || true

echo "Containers stopped successfully!"
