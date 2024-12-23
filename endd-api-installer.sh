#!/bin/bash

echo "[endd-api-installer] Does your device support binary links? (y/n)"
read -n 1 bin_links
if [[ $bin_links == "y" || $bin_links == "Y" ]]; then
  npm install https://github.com/Wd-Endd/endd-api.git
  cd node_modules/endd-api
  # npm install --only=dev
  tsc
else
  npm install https://github.com/Wd-Endd/endd-api.git --no-bin-links
  cd node_modules/endd-api
  # npm install --only=dev --no-bin-links
  tsc
fi

echo "[endd-api-installer] Complete in 3s..."
read -t 3 -n 1 dev

sleep 3

if [ -n "$dev" ]; then
  echo "[endd-api-installer] Setting up dev mode..."
  git clone https://github.com/Wd-Endd/endd-api.git
  mv ./endd-api/* ./
  rm -rf ./endd-api
fi

echo "[endd-api-installer] Complete!"