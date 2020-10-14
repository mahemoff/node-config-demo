#!/usr/bin/env node

import yargs from 'yargs'
import fs from 'fs'
import path from 'path'
import { hideBin } from 'yargs/helpers'
import os from 'os';

// some ideas here from https://github.com/pump-io/pump.io/blob/464668b2fc091313a6062426f5746663dfe914e5/bin/pump#L33

function getPossiblePaths(configPath) {
  return [
    configPath,
    `${os.homedir()}/.game_config.json`,
    './game_config.json',
    '/etc/game_config.json'
  ];
}

const args = yargs(hideBin(process.argv))
  .default("config", "/dev/null") // force config method to run even if wasn't specified
  .config('config', (configPath) => {
    for (const path of getPossiblePaths(configPath)) {
      try {
        return JSON.parse(fs.readFileSync(path, 'utf-8'));
      } catch (err) {
        // swallow this, we will then try next path
      }
    }
  })
  .argv;

console.log(JSON.stringify(args, null, 2));
