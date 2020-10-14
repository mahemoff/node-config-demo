#!/usr/bin/env bash

set -e

function run_game() {

  app_args_amount=$(($# - 2))
  desc=$(echo ${@:$(($app_args_amount+1)):1} | awk '{ print toupper($0) }')
  remark=${@:$(($app_args_amount+2))} 
  args=${@:1:$app_args_amount}

  shift
  cat << END
## $desc
$remark

> ./game.js $args

\`\`\`
$(./game.js $args)
\`\`\`

--
END
}

run_games() {
  run_game 'No arguments' 'No app-specific variables are set'
  run_game --time=60 --splash-screen=false 'command-line arguments' 'Variables set directly from command line. Note that a dashed-option gives you both camelCase and snake_case references as a convenience.'
  run_game --time=60 --splash-screen=false --enemy.speed=50 --enemy.visible=true --player.speed=20 --player.human=true 'Nested command line arguments' 'Specify hierarchies using dot notation'
}

preview() {
  #run_games | consolemd -s sas
  #run_games | mdv -t '693.8662, #dcdcdd-#c5c3c6-#46494c-#4c5c68-#1985a1' -
  run_games | glow -s light - >> README.md
  stty echo # glow turns echo off?
}

cat README.preamble.md > README.md
run_games >> README.md
