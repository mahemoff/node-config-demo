# node-config-demo
How to read options from command line, config files, and mix both. With Node and Yargs.
## NO ARGUMENTS
No app-specific variables are set.

> ./game.js 

```
{
  "_": [],
  "$0": "game.js"
}
```

--
# COMMAND LINE ARGUMENTS
## COMMAND-LINE ARGUMENTS
Variables set directly from command line. Note that a dashed-option gives you both camelCase and snake_case references as a convenience.

> ./game.js --time=60 --splash-screen=false

```
{
  "_": [],
  "time": 60,
  "splash-screen": "false",
  "splashScreen": "false",
  "$0": "game.js"
}
```

--
## NESTED COMMAND LINE ARGUMENTS
Specify hierarchies using dot notation.

> ./game.js --time=60 --splash-screen=false --enemy.speed=50 --enemy.visible=true --player.speed=20 --player.human=true

```
{
  "_": [],
  "time": 60,
  "splash-screen": "false",
  "splashScreen": "false",
  "enemy": {
    "speed": 50,
    "visible": "true"
  },
  "player": {
    "speed": 20,
    "human": "true"
  },
  "$0": "game.js"
}
```

--
# CONFIG FILE
## SIMPLE CONFIG FILE
Instead of using command-line, its possible to include options in a file with yargs config() method.

> ./game.js --config=config/game.json

```
{
  "_": [],
  "config": "config/game.json",
  "time": 30,
  "splash-screen": true,
  "splashScreen": true,
  "enemy": {
    "speed": 100,
    "visible": false
  },
  "player": {
    "speed": 30,
    "human": false
  },
  "$0": "game.js"
}
```

--
## TOML CONFIG FILE
It doesnt have to be a JSON file. Any format can be used as long as theres a way to parse it into a hash, so well demo TOML here.

> ./game.js --config=config/game.toml

```
{
  "_": [],
  "config": "config/game.toml",
  "time": 45,
  "splash-screen": true,
  "splashScreen": true,
  "enemy": {
    "speed": 100,
    "visible": false
  },
  "player": {
    "speed": 40,
    "visible": true
  },
  "$0": "game.js"
}
```

--
## TOML CONFIG FILE
It doesnt have to be a JSON file. Any format can be used as long as theres a way to parse it into a hash, so well demo TOML here.

> ./game.js --config=config/game.toml

```
{
  "_": [],
  "config": "config/game.toml",
  "time": 45,
  "splash-screen": true,
  "splashScreen": true,
  "enemy": {
    "speed": 100,
    "visible": false
  },
  "player": {
    "speed": 40,
    "visible": true
  },
  "$0": "game.js"
}
```

--
# MIXING COMMAND LINE ARGUMENTS WITH CONFIG FILE
## SAME OPTION ON BOTH COMMAND LINE AND CONFIG FILE
As the results show, both config and command line are used. The config file provides defaults, which the command line can override.

> ./game.js --time=60 --config=config/simple_game.json

```
{
  "_": [],
  "time": 60,
  "config": "config/simple_game.json",
  "splash-screen": true,
  "splashScreen": true,
  "enemy": {
    "speed": 100,
    "visible": false
  },
  "player": {
    "speed": 30,
    "human": false
  },
  "$0": "game.js"
}
```

--
## NESTED OPTIONS ON BOTH COMMAND LINE AND CONFIG FILE
Again, options present in both will be determined by the command line as it has priority. As before, options only in one or the other will still be respected, this time with nesting.

> ./game.js --time=60 --enemy.speed=25 --physics.gravity=5 --config=config/game.json

```
{
  "_": [],
  "time": 60,
  "enemy": {
    "speed": 25,
    "visible": false
  },
  "physics": {
    "gravity": 5
  },
  "config": "config/game.json",
  "splash-screen": true,
  "splashScreen": true,
  "player": {
    "speed": 30,
    "human": false
  },
  "$0": "game.js"
}
```

--
