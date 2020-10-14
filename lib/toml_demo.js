#!/usr/bin/env node

import yargs from 'yargs'
import fs from 'fs'
import path from 'path'
import { hideBin } from 'yargs/helpers'
import TOML from 'toml'

const args = yargs(hideBin(process.argv))
  .config('config', function (configPath) {
    return TOML.parse(fs.readFileSync(configPath, 'utf-8'))
  })
  .argv;

console.log(JSON.stringify(args, null, 2));
