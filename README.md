# node-config-demo
How to read options from command line, config files, and mix both. With Node and Yargs.
## NO ARGUMENTS
No app-specific variables are set

> ./game.js 

```
{
  "_": [],
  "$0": "game.js"
}
```

--
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
Include hierarchies using dot notation

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
