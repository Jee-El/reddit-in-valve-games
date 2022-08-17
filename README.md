# dad-jokes-in-valve-games

Automatically get dad jokes from reddit, bind them to keys in a Valve game, share them in the chat with the other players.

## Why?

1. I find these jokes the funniest, so I've been enjoying spamming them in the chat for the other players to read & laugh (some find them unfunny, which is fair, but I like making them read them anyways haha).

2. I've lately been doing this manually, copy-pasting jokes and binding them to keys, which would take me quite a bit of time daily and eventually made me lazy to update them, so I thought why not automate the whole thing.

## Notes

These guides are just a few out of plenty, so feel free to use any other guide(s) to get git and ruby installed. (Bundler is optional)

Also, the linux guides are mainly for Ubuntu and its official flavors.

In this guide, we'll use the game Counter Strike Global Offensive, but this should work on any other valve game that has a console, so if you are doing this to another game, just browse/open the folders for your specific game.

# Guide on how to use it

## Install Git

### On Windows

Follow this guide until 1:48 :

[youtube](https://www.youtube.com/watch?v=2j7fD92g-gE)

### On Linux/MacOS/Chrome OS/CloudReady

Follow only the first step (Step 1) of this guide :

https://www.theodinproject.com/lessons/foundations-setting-up-git

## Install ruby

### On Windows

You can install it on here :

https://rubyinstaller.org/

And here's a video that will guide you through the installation process :

[youtube](https://www.youtube.com/watch?v=XC1ccTyhLPI)

### On Linux/MacOS

Follow this guide :

https://www.theodinproject.com/lessons/ruby-installing-ruby

Feel free to ignore the "Extras" section.

## Install Bundler (Optional)

In your terminal or git bash :

`gem install bundler`

## Clone this repository

`git clone https://github.com/Jee-El/dad-jokes-in-valve-games.git`

`cd dad-jokes-in-valve-games`

## Install the gems

`bundle install`

## Setup the json file

Navigate to the dad-jokes-in-valve-games directory if you aren't there already. You'll see a config.json file, where you'll setup your settings, open it in a text editor.

You'll see 5 entries, the only ones you should be changing the values of are the LAST TWO, "dad_jokes_cfgs" and "keys".

1. Make your own .cfg file, to do this, just copy one of the .cfg files in this path

(make sure to replace STEAMID with your steam id, and HOSTNAME with your hostname if you're on linux)

`C:\Program Files (x86)\Steam\userdata\STEAMID\730\local\cfg`

or

`/home/HOSTNAME/.steam/steam/userdata/STEAMID/730/local/cfg`

rename it (e.g: dad_jokes.cfg), empty it from any text (optional).

Copy the same file and also put it in this path

`C:\Program Files (x86)\Steam\Steamapps\common\Counter-Strike: Global Offensive\csgo\cfg`

or

`/home/HOSTNAME/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg`

In the "dad_jokes_cfgs" in the json file, replace the text "PUT ONE OF THE TWO PATHS TO THE .cfg FILE HERE" & "PUT THE OTHER PATH HERE" with the paths to your .cfg file, make sure the end of the path is the file name and its extension cfg.

e.g:

`/home/HOSTNAME/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/dad_jokes.cfg`

### Note

Normally, only one of the paths is necessary, but I've had issues before with the .cfg file, sometimes it worked on the first path, sometimes on the second, so just use both since there is no downside to that.

Now go to the "keys" in the json file, and replace the values (f1, f2, ..., f10) with the keys you want the jokes to be bound to and save the changes.

## Setup the dad_jokes.cfg file with your game

steam => view (top left) => library => Find your game and right click on it => properties => general => launch options

Now type : +exec dad_jokes

If later you realize that it doesn't work, try : +exec dad_jokes.cfg

(Use the name you gave to the file, dad_jokes is what I named it).

## Setup a shortcut to run the script (optional)

### Windows

https://www.wikihow.com/Run-Command-Prompt-Commands-from-a-Windows-Shortcut

Use same command as below.

### Linux

Look for shortcuts in the system's search bar or settings, click on the plus icon to add a shortcut, name it whatever you want, give it the combination of keys you want (e.g: alt + /), in the command field type :

`bundle exec ruby /home/HOSTNAME/dad-jokes-in-valve-games/main.rb`

The path depends on where you cloned the repository and your OS, so adjust accordingly.

# And Done!

Now just use the shortcut if you've made one, or run the command by yourself on gitbash or terminal, then open csgo, or your valve game of choice, and enjoy spamming the chat with your jokes!

# Final Notes

## One issue

I'm facing an issue on Linux (Ubuntu) where the binds don't apply to the game automatically, though the .cfg file gets updated, so it's an issue with my OS or the game. If you face the same issue, you can either run `exec dad_jokes` in the console everytime you open the game and everything will work as it should, or bind a key to do that for you :

`bind "f1" "exec dad_jokes"`

## A warning

It's better not to change any other settings in the .json file unless you know what you are doing. Currently the script will work, meaning you can use the shortcut or run the command, a maximum of 30 times a day (since the last time you ran the script for the first time), sometimes less, this is because sending too many requests to reddit sounds like a bad idea, but yeah you can change the "maximum_requests" value to a higher value if you want to be able to use it more than 30 times.

The good thing is that the top page of reddit's subreddit dadjokes isn't updated often enough for you to use the shortcut many times for a meaningful reason, so you'll just see the same jokes bound to the same keys.
