#!/bin/bash

echo "Building Docker images for Blue and Green deployments..."

# Build Blue image
cd blue
sudo docker build -t ses_1:blue .

cd ..

# Build Green image
cd green
sudo docker build -t ses_1:green .

cd ..

echo "Docker images built successfully!"
