#!/usr/bin/env bash

set -e

function section() {
  echo "# $1"
}

function run_game() {

  app_args_amount=$(($# - 3))
  script=${@:$(($app_args_amount+1)):1} 
  desc=$(echo ${@:$(($app_args_amount+2)):1} | awk '{ print toupper($0) }')
  remark=${@:$(($app_args_amount+3))} 
  args=${@:1:$app_args_amount}

  shift
  cat << END
## $desc
$remark

> $script.js $args

\`\`\`
$(./lib/$script.js $args)
\`\`\`

--
END
}

run_games() {

  section 'BASE CASE'
  run_game 'demo' 'No arguments' 'No app-specific variables are set.'

  section 'COMMAND LINE ARGUMENTS'
  run_game --time=60 --splash-screen=false 'demo' 'command-line arguments' 'Variables set directly from command line. Note that a dashed-option gives you both camelCase and snake_case references as a convenience.'
  run_game --time=60 --splash-screen=false --enemy.speed=50 --enemy.visible=true --player.speed=20 --player.human=true 'demo' 'Nested command line arguments' 'Specify hierarchies using dot notation.'

  section 'CONFIG FILE'
  run_game  --config=config/game.json 'demo' 'Simple config file' 'Instead of using command-line, it''s possible to include options in a file with yargs'' config() method.'
  run_game  --config=config/game.toml 'toml_demo' 'TOML config file' 'It doesn''t have to be a JSON file. Any format can be used as long as there''s a way to parse itng  into a hash, so we''ll use a different config() here to support TOML instead.'
  run_game  'flexible_config_demo' 'Flexible config files' 'In this case, config() has been modified to support looking for config in standard locations. You can try making a JSON file (with any content) at ~/.game.json and re-running the demo.'

  section 'MIXING COMMAND LINE ARGUMENTS WITH CONFIG FILE'
  run_game --time=60 --config=config/simple_game.json 'demo' 'Same option on both command line and config file' 'As the results show, both config and command line are used. The config file provides defaults, which the command line can override.'
  run_game --time=60 --enemy.speed=25 --physics.gravity=5 --config=config/game.json 'demo' 'Nested options on both command line and config file' 'Again, options present in both will be determined by the command line as it has priority. As before, options only in one or the other will still be respected, this time with nesting.'
  
}

preview() {
  #run_games | consolemd -s sas
  #run_games | mdv -t '693.8662, #dcdcdd-#c5c3c6-#46494c-#4c5c68-#1985a1' -
  run_games | glow -s light - >> README.md
  stty echo # glow turns echo off?
}

cat README.preamble.md > README.md
run_games >> README.md 2>&1
