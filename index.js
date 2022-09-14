'use strict';

const { app, BrowserWindow } = require('electron');
const path = require('path');
const fs = require('fs');
const { ipcMain } = require('electron');
const { execSync } = require('child_process');

let clonedRepoPath = getClonedRepoPath()
  .toString()
  .split('\n')
  .find((path) => !path.includes('.config'));
let configPath = clonedRepoPath + '/config.json';
let unparsedConfig = fs.readFileSync(configPath);
let config = JSON.parse(unparsedConfig);

function getClonedRepoPath() {
  return execSync(
    'bash -c "find ~ -type d -name reddit-in-valve-games 2> /dev/null"'
  );
}

const createWindow = () => {
  const win = new BrowserWindow({
    width: 1000,
    height: 1000,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: true,
      preload: path.resolve(clonedRepoPath + '/preload.js'),
    },
  });
  win.loadFile(clonedRepoPath + '/index.html');
};

ipcMain.on('saveSetup', (e, newConfig) => {
  let subredditName = newConfig.subredditName;
  config.currently_used_subreddit_name = subredditName;
  for (let key in newConfig) {
    if (key == 'subredditName') continue;
    config[subredditName][key] = newConfig[key];
  }
  fs.writeFileSync(configPath, JSON.stringify(config));
});

ipcMain.on('addSubreddit', (e, newSubreddit) => {
  let subredditName = newSubreddit.subredditName;
  config[subredditName] = {
    url: newSubreddit.link,
    paths: newSubreddit.paths,
    keys: newSubreddit.keys,
    call_date: null,
    has_to_reset_call_date: true,
    total_requests: 0,
    maximum_requests: 30,
  };
  fs.writeFileSync(configPath, JSON.stringify(config));
});

app.whenReady().then(() => {
  createWindow();
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
