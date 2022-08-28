# NOTE

This branch is NOT tested yet, it likely has some issues, please use the contents in the main branch instead.

If you have this branch locally, just run `git checkout main` so you are on the main branch.

As soon as it is tested, it'll be merged into the main branch.

# dad-jokes-in-valve-games

Automatically get dad jokes from reddit, bind them to keys in a Valve game, share them in the chat with the other players.

## Why?

1. I find these jokes the funniest, so I've been enjoying spamming them in the chat for the other players to read & laugh (some find them unfunny, which is fair, but I like making them read them anyways haha).

2. I've lately been doing this manually, copy-pasting jokes and binding them to keys, which would take me quite a bit of time daily and eventually made me lazy to update them, so I thought why not automate the whole thing.

## Notes

- Originally, this was made only for the dadjokes subreddit, but It should work quite well with other text-only subreddits so feel free to try it out!

- Contact me on discord if you face any issues, it's on my github page, or create an issue on this repository.

- The guides provided are just a few out of plenty, so feel free to use any other guide(s) to get git, ruby, and bundler installed.

- Also, the linux guides are mainly for Ubuntu and its official flavors, but it should be easy to find guides for other distributions.

- In this guide, we'll use the game Counter Strike Global Offensive, but this should work on any other valve game that has a console and a chat system, so if you are doing this to another game, just browse/open the folders for your specific game.

- I'll also use the /r/dadjokes subreddit here, but you can try the same script with other subreddits that allow text-only posts. _See final notes on how to use with other subreddits._

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

## Install Bundler

In your terminal or git bash :

`gem install bundler`

## Clone this repository

`git clone https://github.com/Jee-El/dad-jokes-in-valve-games.git`

`cd dad-jokes-in-valve-games`

`git checkout testing-feature`

## Install the gems

`bundle install`

## Setup the json file

Navigate to the dad-jokes-in-valve-games directory if you aren't there already. You'll see a config.json file, where you'll setup your settings, open it in a text editor.

You'll see 3 entries. The only ones you should be changing are : "currently_used_subreddit_name", "subreddit_name", "url", "paths", "keys".

We'll be using the dadjokes entry and its nested entries in this guide.

### On Windows

On windows, it's a bit simpler since I set it up for windows.

1. In the "paths" entry, replace STEAMID in the first path with your own steam ID.

(Ignore the double backslashes, one is there to escape the other, so they're necessary)

`"C:\\Program Files (x86)\\Steam\\userdata\\STEAMID\\730\\local\\cfg\\"`

If you're setting this up for CSGO, leave the second path as it is.

If you're not, change "Counter-Strike: Global Offensive" with the name of your game's folder. You can follow the path until you're in the "common" folder and you'll find your game's folder there.

### On Linux

1. In the "paths" entry, replace the paths with these :

`/home/HOSTNAME/.steam/steam/userdata/STEAMID/730/local/cfg/`

`/home/HOSTNAME/.steam/steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg/`

Replace STEAMID with your steam ID, HOSTNAME with your hostname (run `whoami` in the terminal to get it).

If you didn't copy-paste the paths, make sure that both of them start with /home/HOSTNAME and not ~/, and that they end with a forward slash so it works as it should.

If you're setting this up for CSGO, leave the second path as it is.

If you're not, change "Counter-Strike: Global Offensive" with the name of your game's folder. You can follow the path until you're in the "common" folder and you'll find your game's folder there.

### Note

Normally, only one of the paths is necessary, but I've had issues before with the .cfg file, sometimes it worked on the first path, sometimes on the second, so just use both since there is no downside to that.

If you want, you can experiment with this by removing one path and keeping the other, once you find the working one, use it alone.

### On Windows and Linux

Now go to the "keys" entry, the one inside the "dadjokes" entry, in the json file, and replace the values (f1, f2, ..., f5) with the keys you want the jokes to be bound to and save the changes.

## Setup the dadjokes.cfg file with your game

Wondering about what dadjokes.cfg file we're talking about? Don't worry, the script will make it once you run it.

steam => view (top left) => library => Find your game and right click on it => properties => general => launch options

Now type : +exec dadjokes

If later you realize that it doesn't work, try : +exec dadjokes.cfg

## Setup a shortcut to run the script (optional)

### Windows

https://www.wikihow.com/Run-Command-Prompt-Commands-from-a-Windows-Shortcut

Use same command as below.

### Linux

Look for shortcuts in the system's search bar or settings, click on the plus icon to add a shortcut, name it whatever you want, give it the combination of keys you want (e.g: alt + /), in the command field type :

`bundle exec ruby /home/HOSTNAME/dad-jokes-in-valve-games/main.rb`

The path depends on where you cloned the repository and your OS, so adjust accordingly, the one above is for linux.

# And Done!

Now just use the shortcut if you've made one, or run this command by yourself on gitbash or terminal :

`bundle exec ruby /home/HOSTNAME/dad-jokes-in-valve-games/main.rb`

Again, make sure to adjust the path according to where you cloned this repository, and your OS.

then open csgo, or your valve game of choice, and enjoy sharing the jokes in the chat!

You can type, in the console, this command to see if the binds have been updated :

`key_listboundkeys`

# Final Notes

## One issue

I'm facing an issue on Linux (Ubuntu) where the binds don't apply to the game automatically, though the .cfg file gets updated, so it's an issue with my OS or the game. If you face the same issue, you can either run `exec dadjokes` in the console everytime you open the game and everything will work as it should, or bind a key to do that for you :

`bind "f1" "exec dad_jokes"`

In this case, you just press F1 each time you run the script and you want to update the binds.

## To stay up to date with the changes/fixes

In the terminal/git bash :

`cd dad-jokes-in-valve-games`

`git checkout testing-feature`

`git pull origin testing-feature`

## How to change subreddit or setup multiple ones

Go to the config.json file, the second entry named "subreddit_name" is a template to use to set it up for other subreddits

1. Copy-paste it

2. Replace "subreddit_name" with the name of the subreddit you want (doesn't have to be accurate, it'll be used to name your .cfg file).

3. Replace "SUBREDDITNAME" in the end of value of "url" with the subreddit name (must be accurate).

4. For the paths, just follow the steps that I already listed above.

3. Replace the value of "currently_used_subreddit_name" with the name of the subreddit you want to use (whatever name you used to replace "subreddit_name")

If this is too confusing, you have the template and the dadjokes example, they should help you set everything up!

## Some Warnings

- DO NOT make two entries with the same "subreddit_name" value.

- DO NOT replace "subreddit_name" with the name of a .cfg file that's already in either/both paths. For example, it's common to have a file called config.cfg or autoexec.cfg, so don't replace "subreddit_name" with "config" or "autoexec", it'll delete all the contents inside them.

- It's better not to change any other settings in the .json file unless you know what you are doing. Currently the script will work, meaning you can use the shortcut or run the command, a maximum of 30 times a day (since the last time you ran the script for the first time), sometimes less, this is because sending too many requests to reddit sounds like a bad idea, but yeah you can change the "maximum_requests" value to a higher value if you want to be able to use it more than 30 times. The good thing is that the hot page of subreddits isn't updated often enough for you to use the shortcut many times for a meaningful reason, so you'll just see the same contents bound to the same keys.
