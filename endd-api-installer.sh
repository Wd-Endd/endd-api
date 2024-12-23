#!/bin/bash

# move function 
safe_move() {
  local source_dir=$1
  local target_dir=$2

  for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
      local base_file=$(basename "$file")
      if [ -f "$target_dir/$base_file" ]; then
        cmp -s "$file" "$target_dir/$base_file" || mv "$file" "$target_dir/"
      else
        mv "$file" "$target_dir/"
      fi
    fi
  done
}

echo "[endd-api-installer] Does your device support binary links? (y/n)"
read -n 1 bin_links
if [[ $bin_links == "y" || $bin_links == "Y" ]]; then
  npm install https://github.com/Wd-Endd/endd-api.git;
  cd node_modules/endd-api
  # npm install --only=dev
  tsc
else
  npm install https://github.com/Wd-Endd/endd-api.git --no-bin-links;
  cd node_modules/endd-api
  # npm install --only=dev --no-bin-links
  tsc
fi

echo "[endd-api-installer] Complete in 3s"
read -t 3 -n 1 dev
if [ -n "$dev" ]; then
  sleep 0.5
  echo "[endd-api-installer] Setting up dev mode..."
  git clone https://github.com/Wd-Endd/endd-api.git
  safe_move "./endd-api/*" "."
  rm -rf ./endd-api
fi

echo "[endd-api-installer] Complete!"