# NOTE

This branch is NOT tested yet, it likely has some issues, please use the contents in the main branch instead.

If you have this branch locally, just run `git checkout main` so you are on the main branch.

As soon as it is tested, it'll be merged into the main branch.

# dad-jokes-in-valve-games

Automatically get dad jokes from reddit, bind them to keys in a Valve game, share them in the chat with the other players.

# Contents

- [Why?](#why)

- [Notes](#notes)

- [Guide](#guide)

  1. [Install Git](#install-git)

     - [Windows](#on-windows)

     - [Linux](#on-linux)

  2. [Install Ruby](#install-ruby)

     - [On Windows](#on-windows-1)

     - [On Linux](#on-linux-1)

  3. [Install Bundler](#install-bundler)

  4. [Clone This Repository](#clone-this-repository)

  5. [Install Required Gems](#install-required-gems)

  6. [Setup the JSON file](#setup-the-json-file)

     - [For Windows](#for-windows)

     - [For Linux](#for-linux)

     - [Why Two Paths?](#why-two-paths)

     - [For Windows and Linux](#for-windows-and-linux)

  7. [Setup The dadjokes.cfg File](#setup-the-dadjokescfg-file)

  8. [Multiple Subreddits](#multiple-subreddits)

  9. [Done!](#done)

- [IMPORTANT](#important)

  - [One Issue](#one-issue)

  - [Stay Up To Date](#to-stay-up-to-date-with-the-changesfixes)

  - [Some Warnings](#some-warnings)

# Why?

1. I find these jokes the funniest, so I've been enjoying spamming them in the chat for the other players to read & laugh (some find them unfunny, which is fair, but I like making them read them anyways haha).

2. I've lately been doing this manually, copy-pasting jokes and binding them to keys, which would take me quite a bit of time daily and eventually made me lazy to update them, so I thought why not automate the whole thing.

# Notes

- Originally, this was made only for the dadjokes subreddit, but It should work quite well with other text-only subreddits so feel free to try it out!

- If you face any issues, contact me on reddit /u/jee-el, or open an issue on this repository.

- The guides provided are just a few out of plenty, so feel free to use any other guide(s) to get git, ruby, and bundler installed.

- Also, the linux guides are mainly for Ubuntu and its official flavors, but it should be easy to find guides for other distributions.

- In this guide, we'll use the game Counter Strike Global Offensive, but this should work on any other valve game that has a console and a chat system, so if you are doing this to another game, just browse/open the folders for your specific game.

- I'll also use the /r/dadjokes subreddit here, but you can try the same script with other subreddits that allow text-only posts. _See final notes on how to use with other subreddits._

# Guide

## Install Git

### On Windows

Follow this guide until 1:48 :

[youtube](https://www.youtube.com/watch?v=2j7fD92g-gE)

### On Linux

Follow only the first step (Step 1) of this guide :

https://www.theodinproject.com/lessons/foundations-setting-up-git

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

`git clone https://github.com/Jee-El/dad-jokes-in-valve-games.git`

`cd dad-jokes-in-valve-games`

`git checkout testing-feature`

## Install Required Gems

`bundle install`

## Setup The JSON File

Navigate to the dad-jokes-in-valve-games directory if you aren't there already. You'll see a config.json file, where you'll setup your settings, open it in a text editor.

You'll see 3 entries. The only ones you should be changing are : "currently_used_subreddit_name", "SUBREDDIT_NAME", "url", "paths", "keys".

We'll be using the dadjokes entry and its nested entries in this guide.

### For Windows

On windows, it's a bit simpler since I set it up for windows.

1. In the "paths" entry, replace STEAMID in the first path with your own steam ID.

(Ignore the double backslashes, one is there to escape the other, so they're necessary)

`"C:\\Program Files (x86)\\Steam\\userdata\\STEAMID\\730\\local\\cfg\\"`

If you're setting this up for CSGO, leave the second path as it is.

If you're not, change "Counter-Strike: Global Offensive" with the name of your game's folder. You can follow the path until you're in the "common" folder and you'll find your game's folder there.

### For Linux

1. In the "paths" entry, replace the paths with these :

`/home/HOSTNAME/.steam/steam/userdata/STEAMID/730/local/cfg/`

`/home/HOSTNAME/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/`

Replace STEAMID with your steam ID, HOSTNAME with your hostname (run `whoami` in the terminal to get it).

If you didn't copy-paste the paths, make sure that both of them start with /home/HOSTNAME and not ~/, and that they end with a forward slash so it works as it should.

If you're setting this up for CSGO, leave the second path as it is.

If you're not, change "Counter-Strike: Global Offensive" with the name of your game's folder. You can follow the path until you're in the "common" folder and you'll find your game's folder there.

### Why Two Paths?

Normally, only one of the paths is necessary, but I've had issues before with the .cfg file, sometimes it worked on the first path, sometimes on the second, so just use both since there is no downside to that.

If you want, you can experiment with this by removing one path and keeping the other, once you find the working one, use it alone.

### For Windows and Linux

Now go to the "keys" entry, the one inside the "dadjokes" entry, in the json file, and replace the values (f1, f2, ..., f5) with the keys you want the jokes to be bound to and save the changes.

## Setup The dadjokes.cfg File

Wondering about what dadjokes.cfg file we're talking about? Don't worry, the script will make it once you run it.

steam => view (top left) => library => Find your game and right click on it => properties => general => launch options

Now type : +exec dadjokes

If later you realize that it doesn't work, try : +exec dadjokes.cfg

## Multiple Subreddits

Go to the config.json file, the second entry named "SUBREDDIT_NAME" is a template to use to set it up for other subreddits

1. Copy-paste it

2. Replace "SUBREDDIT_NAME" with the name of the subreddit you want (doesn't have to be accurate, it'll be used to name your .cfg file).

3. Replace "SUBREDDIT*NAME" \_in the "url" entry* with the subreddit name (must be accurate).

4. For the paths, just follow the steps that I already listed above.

5. Replace the value of "currently_used_subreddit_name" with the name of the subreddit you want to use (whatever name you used to replace "SUBREDDIT_NAME")

If this is too confusing, you have the template and the dadjokes example, they should help you set everything up!

# Done!

- Run this command to navigate to where you cloned this repository, replace the path with the path to the folder named _dad-jokes-in-valve-games_ : `cd <path>`

Don't include the greater-than/less-than symbols.

Run `pwd`, it should return a path ending with _dad-jokes-in-valve-games_, if it doesn't, double check the path you entered.

Finally, run : `bundle exec ruby main.rb`

Wait until it's done. When it's done, it should return some ouput.

Open csgo, or your valve game of choice, and enjoy sharing the jokes in the chat!

You can type, in the console, this command to see if the binds have been updated :

`key_listboundkeys`

# IMPORTANT

## One issue

I'm facing an issue on Linux (Ubuntu) where the binds don't apply to the game automatically, though the .cfg file gets updated, so it's an issue with my OS or the game. If you face the same issue, you can either run `exec dadjokes` in the console everytime you open the game and everything will work as it should, or bind a key to do that for you :

`bind "f1" "exec dad_jokes"`

In this case, you just press F1 each time you run the script and you want to update the binds.

## To stay up to date with the changes/fixes

- Store a copy of your `config.json` file somewhere else.

- In the terminal/git bash (same path mentioned [above](#done)) :

`cd <path>`

`git checkout testing-feature`

`git pull origin testing-feature`

## Some Warnings

- DO NOT make two entries with the same "SUBREDDIT_NAME" value.

- DO NOT replace "SUBREDDIT_NAME" with the name of a .cfg file that's already in either/both paths. For example, it's common to have a file called config.cfg or autoexec.cfg, so don't replace "SUBREDDIT_NAME" with "config" or "autoexec", it'll delete all the contents inside them.

- It's better not to change any other settings in the .json file unless you know what you are doing. Currently the script will work, meaning you can use the shortcut or run the command, a maximum of 30 times a day (since the last time you ran the script for the first time), sometimes less, this is because sending too many requests to reddit sounds like a bad idea, but yeah you can change the "maximum_requests" value to a higher value if you want to be able to use it more than 30 times. The good thing is that the hot page of subreddits isn't updated often enough for you to use the shortcut many times for a meaningful reason, so you'll just see the same contents bound to the same keys.
