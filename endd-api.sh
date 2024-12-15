#!/bin/bash

echo "[endd-api-installer] Does your device support binary links? (y/n)"
read -n 1 bin_links
if [[ $bin_links == "y" || $bin_links == "Y" ]]; then
  npm install https://github.com/Wd-Endd/endd-api.git
else
  npm install https://github.com/Wd-Endd/endd-api.git --no-bin-links
fi

cd node_modules/endd-api
tsc