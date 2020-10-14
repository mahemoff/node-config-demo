#!/usr/bin/env node

import yargs from 'yargs'
import util from 'util'
import fs from 'fs'
import path from 'path'
import { hideBin } from 'yargs/helpers'
import TOML from 'toml'

var args = yargs(hideBin(process.argv))
  .config('config', function (configPath) {
    // Normally this would be a one liner with a single format supported. But
    // for demo purposes, we'll show that various formats are possible
    switch(path.extname(configPath)) {
      case '.json': 
        return JSON.parse(fs.readFileSync(configPath, 'utf-8'))
      case '.toml':
        return TOML.parse(fs.readFileSync(configPath, 'utf-8'))
      default:
        console.error('unknown format!');
        return
    }
  })
  .argv;

console.log(JSON.stringify(args, null, 2));
