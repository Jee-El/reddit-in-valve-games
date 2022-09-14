const { ipcRenderer } = require('electron');
const fs = require('fs');
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

document.addEventListener('DOMContentLoaded', () => {
  const firstPathInput = document.querySelector('#first-path');
  const secondPathInput = document.querySelector('#second-path');
  const keysInput = document.querySelector('#keys');
  keysInput.addEventListener('change', (e) => {
    e.target.value = e.target.value.replace(' ', '').split(',').join(', ');
  });

  if (window.location.href.includes('index.html')) {
    var subredditsSelect = document.querySelector('select');
    subredditsSelect.addEventListener('input', () =>
      updateInput(subredditsSelect, firstPathInput, secondPathInput, keysInput)
    );
    const saveBtn = document.querySelector('#save-btn');
    saveBtn.addEventListener('click', () =>
      getUpdatedConfig(
        subredditsSelect,
        firstPathInput,
        secondPathInput,
        keysInput
      )
    );
    const runBtn = document.querySelector('#run-btn');
    runBtn.addEventListener('click', () => {
      getUpdatedConfig(
        subredditsSelect,
        firstPathInput,
        secondPathInput,
        keysInput
      );
      execSync(`bash -c "bundle exec ruby ${clonedRepoPath}/lib/main.rb"`);
    });
    fillUpTheDefaultForm(
      subredditsSelect,
      firstPathInput,
      secondPathInput,
      keysInput
    );
  } else {
    var subredditName = document.querySelector('#subreddit-name');
    var subredditLink = document.querySelector('#subreddit-link');
    const addBtn = document.querySelector('#add-btn');
    addBtn.addEventListener('click', () => {
      let subreddit = {
        subredditName: subredditName,
        subredditLink: subredditLink,
        paths: [firstPathInput, secondPathInput],
        keys: keysInput,
      };
      ipcRenderer.send('addSubreddit', subreddit);
    });
  }
});

function fillUpTheDefaultForm(
  subredditsSelect,
  firstPathInput,
  secondPathInput,
  keysInput
) {
  createOptions(subredditsSelect);
  fillUpPaths(firstPathInput, secondPathInput);
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

function fillUpPaths(firstPathInput, secondPathInput) {
  let subredditName = config.currently_used_subreddit_name;
  firstPathInput.value = config[subredditName].paths[0];
  secondPathInput.value = config[subredditName].paths[1];
}

function fillUpKeys(keysInput) {
  let subredditName = config.currently_used_subreddit_name;
  keysInput.value = config[subredditName].keys.join(', ');
}

function getUpdatedConfig(
  subredditsSelect,
  firstPathInput,
  secondPathInput,
  keysInput
) {
  const subredditName = Array.from(document.querySelectorAll('option')).find(
    (option) => {
      return subredditsSelect.value === option.value;
    }
  ).textContent;
  let firstPath = firstPathInput.value;
  let secondPath = secondPathInput.value;
  let keys = keysInput.value.replace(' ', '').split(',');

  let newConfig = {
    subredditName: subredditName,
    paths: [firstPath, secondPath].filter((path) => path !== ''),
    keys: keys,
  };
  ipcRenderer.send('saveSetup', newConfig);
}

function updateInput(
  subredditsSelect,
  firstPathInput,
  secondPathInput,
  keysInput
) {
  const subredditName = Array.from(document.querySelectorAll('option')).find(
    (option) => {
      return subredditsSelect.value === option.value;
    }
  ).textContent;
  updatePaths(subredditName, firstPathInput, secondPathInput);
  updateKeys(subredditName, keysInput);
}

function updatePaths(subredditName, firstPathInput, secondPathInput) {
  const bothPaths = config[subredditName].paths;
  firstPathInput.value = bothPaths[0];
  secondPathInput.value = bothPaths[1];
}

function updateKeys(subredditName, keysInput) {
  keysInput.value = config[subredditName].keys.join(', ');
}

function resetInput() {
  document.querySelectorAll('input').forEach((input) => {
    input.value = '';
  });
}
