#!/usr/bin/env node

import yargs from 'yargs'
import util from 'util'
import fs from 'fs'
import { hideBin } from 'yargs/helpers'
import prettyPrintJson from 'pretty-print-json'

var args = yargs(hideBin(process.argv))
  .config('config', function (configPath) {
    return JSON.parse(fs.readFileSync(configPath, 'utf-8'))
  })
  .argv;

console.log(JSON.stringify(args, null, 2));
