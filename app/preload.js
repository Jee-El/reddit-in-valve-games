const { ipcRenderer } = require('electron');
const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

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

document.addEventListener('DOMContentLoaded', () => {
  const mainContainer = document.querySelector('.main-container');
  const firstPathInput = document.querySelector('#first-path');
  const secondPathInput = document.querySelector('#second-path');
  const pathsInput = [firstPathInput, secondPathInput];
  pathsInput.forEach((pathInput) => {
    pathInput.addEventListener('change', (e) => {
      if (e.target.value == '') return;

      separator = e.target.value.includes('/') ? '/' : '\\';
      e.target.value = e.target.value.endsWith(separator)
        ? e.target.value
        : e.target.value + separator;
    });
  });
  const keysInput = document.querySelector('#keys');
  keysInput.addEventListener('change', (e) => {
    e.target.value = e.target.value.replace(/\s/g, '').split(',').join(', ');
  });
  const modal = document.querySelector('.modal');
  const p = document.querySelector('.output');
  const okBtn = document.querySelector('.ok');
  okBtn.addEventListener('click', () => hideOutput(mainContainer, modal, p));

  if (window.location.href.includes('index.html')) {
    var subredditsSelect = document.querySelector('select');
    subredditsSelect.addEventListener('input', () =>
      updateInput(subredditsSelect, pathsInput, keysInput)
    );
    const saveBtn = document.querySelector('#save-btn');
    saveBtn.addEventListener('click', () =>
      saveSetup(subredditsSelect, pathsInput, keysInput)
    );
    const runBtn = document.querySelector('#run-btn');
    runBtn.addEventListener('click', () => {
      saveSetup(subredditsSelect, pathsInput, keysInput);
      displayOutput(runRubyScript(), mainContainer, modal, p);
    });
    fillUpTheDefaultForm(subredditsSelect, pathsInput, keysInput);
  } else {
    let subredditNameInput = document.querySelector('#subreddit-name');
    let subredditLinkInput = document.querySelector('#subreddit-link');
    const addBtn = document.querySelector('#add-btn');
    addBtn.addEventListener('click', () => {
      addSubreddit(
        subredditNameInput,
        subredditLinkInput,
        pathsInput,
        keysInput
      );
      modal.style.display = 'flex';
    });
  }
});

function fillUpTheDefaultForm(subredditsSelect, pathsInput, keysInput) {
  createOptions(subredditsSelect);
  fillUpPaths(pathsInput);
  fillUpKeys(keysInput);
}

function createOptions(subredditsSelect) {
  for (let key in config) {
    if (key === 'currently_used_subreddit_name') continue;

    let option = document.createElement('option');
    option.textContent = key;
    option.value = Object.keys(config).indexOf(key);
    subredditsSelect.appendChild(option);
  }
  subredditsSelect.value = Object.keys(config).indexOf(
    config.currently_used_subreddit_name
  );
}

function fillUpPaths(pathsInput) {
  let subredditName = config.currently_used_subreddit_name;
  for (let i = 0; i < pathsInput.length; i++) {
    pathsInput[i].value = config[subredditName].paths[i];
  }
}

function fillUpKeys(keysInput) {
  let subredditName = config.currently_used_subreddit_name;
  keysInput.value = config[subredditName].keys.join(', ');
}

function saveSetup(subredditsSelect, pathsInput, keysInput) {
  const subredditName = Array.from(document.querySelectorAll('option')).find(
    (option) => {
      return subredditsSelect.value === option.value;
    }
  ).textContent;

  let paths = pathsInput
    .map((pathInput) => pathInput.value)
    .filter((path) => path !== '');

  let keys = keysInput.value.replace(/\s/g, '').split(',');

  let newConfig = {
    subredditName: subredditName,
    paths: paths,
    keys: keys,
  };
  ipcRenderer.send('saveSetup', newConfig);
}

function updateInput(subredditsSelect, pathsInput, keysInput) {
  const subredditName = Array.from(document.querySelectorAll('option')).find(
    (option) => {
      return subredditsSelect.value === option.value;
    }
  ).textContent;
  updatePaths(subredditName, pathsInput);
  updateKeys(subredditName, keysInput);
}

function updatePaths(subredditName, pathsInput) {
  const bothPaths = config[subredditName].paths;
  for (let i = 0; i < pathsInput.length; i++) {
    pathsInput[i].value = bothPaths[i];
  }
}

function updateKeys(subredditName, keysInput) {
  keysInput.value = config[subredditName].keys.join(', ');
}

function runRubyScript() {
  return execSync(
    `bash -c "bundle exec ruby ${clonedRepoPath}/lib/main.rb"`
  ).toString();
}

function displayOutput(output, mainContainer, modal, p) {
  p.textContent = output;
  modal.style.display = 'flex';
  mainContainer.classList.add('blurred');
}

function hideOutput(mainContainer, modal, p) {
  mainContainer.classList.remove('blurred');
  modal.style.display = 'none';
  p.textContent = '';
}

function addSubreddit(
  subredditNameInput,
  subredditLinkInput,
  pathsInput,
  keysInput
) {
  let subredditName = subredditNameInput.value;
  let subredditLink = subredditLinkInput.value;
  let paths = pathsInput
    .map((pathInput) => pathInput.value)
    .filter((path) => path !== '');
  let keys = keysInput.value.replace(/\s/g, '').split(',');
  let subreddit = {
    subredditName: subredditName,
    subredditLink: subredditLink,
    paths: paths,
    keys: keys,
  };
  ipcRenderer.send('addSubreddit', subreddit);
}
