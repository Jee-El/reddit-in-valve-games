# reddit-in-valve-games

A desktop application to automatically get text-only contents from reddit, bind them to keyboard keys in a Valve game, share them in the chat with the other players. The GUI is made with ElectronJS, while the scripts that handle everything else are written in Ruby.

## Note

This project was originally made to get only dad jokes from reddit, but I realized I could make it work with other text-only subreddits so I went with that!

# Contents

- [Why?](#why)

- [Notes](#notes)

- [Guide](#guide)

  1. [Install Git](#install-git)

     - [Windows](#on-windows)

     - [Linux](#on-linux)

  2. [Install NodeJS](#install-nodejs)

  3. [Install Ruby](#install-ruby)

     - [On Windows](#on-windows-1)

     - [On Linux](#on-linux-1)

  4. [Install Bundler](#install-bundler)

  5. [Clone This Repository](#clone-this-repository)

  6. [Install Required Gems](#install-required-gems)

  7. [Run The GUI](#run-the-gui)

     - [Why Two Paths?](#why-two-paths)

  8. [Setup The dadjokes.cfg File](#setup-the-dadjokescfg-file)

  9. [Multiple Subreddits](#multiple-subreddits)

  10. [Run The Script](#run-the-script)

  11. [Done!](#done)

- [IMPORTANT](#important)

  - [One Issue](#one-issue)

  - [Stay Up To Date](#to-stay-up-to-date-with-the-changesfixes)

  - [Some Warnings](#some-warnings)

# Why?

1. I find dad jokes incredibly funny, so I've been enjoying spamming them in the chat for the other players to read & laugh (some find them unfunny, which is fair, but I like making them read them anyways haha).

2. I've lately been doing this manually, copy-pasting jokes and binding them to keys, which would take me quite a bit of time daily and eventually made me lazy to update them, so I thought why not automate the whole thing.

# Notes

- If you face any issues, contact me on reddit /u/jee-el, or open an issue on this repository.

- The guides provided are just a few out of plenty, so feel free to use any other guide(s) to get git, ruby, and bundler installed.

- Also, the linux guides are mainly for Ubuntu and its official flavors, but it should be easy to find guides for other distributions.

- In this guide, we'll use the game Counter Strike Global Offensive, but this should work on any other valve game that has a console and a chat system, so if you are doing this to another game, just browse/open the folders for your specific game.

- I'll also use the /r/dadjokes subreddit here, but you can try the same script with other subreddits that allow text-only posts. _See [Multiple Subreddits](#multiple-subreddits) on how to use with other subreddits._

# Guide

## Install Git

### On Windows

Follow this guide until 1:48 :

[youtube](https://www.youtube.com/watch?v=2j7fD92g-gE)

### On Linux

Follow only the first step (Step 1) of this guide :

https://www.theodinproject.com/lessons/foundations-setting-up-git

## Install NodeJS

Follow this guide : https://www.theodinproject.com/lessons/foundations-installing-node-js

## Install ruby

### On Windows

You can install it on here :

https://rubyinstaller.org/

And here's a video that will guide you through the installation process :

[youtube](https://www.youtube.com/watch?v=XC1ccTyhLPI)

### On Linux

Follow this guide :

https://www.theodinproject.com/lessons/ruby-installing-ruby

Feel free to ignore the "Extras" section.

## Install Bundler

In your terminal or git bash :

`gem install bundler`

## Clone This Repository

`git clone https://github.com/Jee-El/reddit-in-valve-games.git`

`cd reddit-in-valve-games`

## Install Required Gems

`bundle install`

## Run The GUI

Navigate to the `reddit-in-valve-games` directory if you aren't there already, and run `npm run start`.

Then, select one of the available subreddits or add a new one.

I'm going to select `dadjokes`.

- For Windows

On windows, it's a bit simpler since I set it up for windows.

1. In the First Path input field, replace STEAMID with your own steam ID.

If you're setting this up for CSGO, leave the second path as it is.

If you're not, change "Counter-Strike: Global Offensive" with the name of your game's folder. You can follow the path until you're in the "common" folder and you'll find your game's folder there.

- For Linux

1. First Path :

`/home/HOSTNAME/.steam/steam/userdata/STEAMID/730/local/cfg/`

2. Second Path :

`/home/HOSTNAME/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/`

Replace STEAMID with your steam ID, HOSTNAME with your hostname (run `whoami` in the terminal to get it).

If you didn't copy-paste the paths, make sure that both of them start with /home/HOSTNAME and not ~/, and that they end with a forward slash so it works as it should.

If you're setting this up for CSGO, leave the second path as it is.

If you're not, change "Counter-Strike: Global Offensive" with the name of your game's folder. You can follow the path until you're in the "common" folder and you'll find your game's folder there.

### Why Two Paths?

Normally, only one of the paths is necessary, but I've had issues before with the .cfg file, sometimes it worked on the first path, sometimes on the second, so just use both since there is no downside to that.

If you want, you can experiment with this by leaving one of the input fields for the paths empty and keeping the other. Once you find the working one, use it alone.

### For Windows and Linux

Now go to the `keys` input field, and enter the keys you want the jokes to be bound to and save the changes.

I suggest you use an even amount of keys, e.g: 2, 4, 6, 8 etc..

## Setup The dadjokes.cfg File

Wondering about what dadjokes.cfg file we're talking about? Don't worry, the script will make it once you run it.

steam => view (top left) => library => Find your game and right click on it => properties => general => launch options

Now type : +exec dadjokes

If later you realize that it doesn't work, try : +exec dadjokes.cfg

## Multiple Subreddits

Click on `Add A Subreddit`, the steps are fairly similar to the ones above.

# Run The Script

Click on the `Run` button.

# Done!

Open csgo, or your valve game of choice, and enjoy sharing the jokes in the chat!

You can type, in the console (as in, the CSGO/CSS/whatever console, not gitbash nor terminal), this command to see if the binds have been updated :

`key_listboundkeys`

# IMPORTANT

## One issue

I'm facing an issue on Linux (Ubuntu) where the binds don't apply to the game automatically, though the .cfg file gets updated, so it's an issue with my OS or the game. If you face the same issue, you can either run `exec dadjokes` in the console (again, the CSGO/CSS/whatever console), everytime you run the script and everything will work as it should, or bind a key to do that for you :

`bind "f1" "exec dad_jokes"`

In this case, you just press F1 each time you run the script and you want to update the binds. (You must be in-game, of course)

## To stay up to date with the changes/fixes

Navigate to the `reddit-in-valve-games` directory/folder, then run `git pull`.

## Some Warnings

- For the subreddit name input field, don't enter the name of a .cfg file that's already in either/both paths. For example, it's common to have a file called config.cfg or autoexec.cfg, so don't enter `config` or `autoexec`, it'll delete all the contents inside them.

- Currently the script will work, meaning you can click on the `Run` button, a maximum of 30 times a day (since the last time you ran the script for the first time), sometimes less, this is because sending too many requests to reddit sounds like a bad idea. The good thing is that the hot pages of subreddits aren't updated often enough for you to run the script many times for a meaningful reason, so you'll just see the same contents bound to the same keys.
