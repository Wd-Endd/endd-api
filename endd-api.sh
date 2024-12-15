#!/bin/bash

echo "[endd-api-installer] Does your device support binary links? (y/n)"
read -n 1 bin_links
if [[ $bin_links == "y" || $bin_links == "Y" ]]; then
  if [ ! -d "node_modules/endd-api" ]; then npm install https://github.com/Wd-Endd/endd-api.git; fi
  cd node_modules/endd-api
  if [ ! -d "node_modules" ]; then npm install; fi
  tsc
else
  if [ ! -d "node_modules/endd-api" ]; then npm install https://github.com/Wd-Endd/endd-api.git --no-bin-links; fi
  cd node_modules/endd-api
  if [ ! -d "node_modules" ]; then npm install --no-bin-links; fi
  tsc
fi
