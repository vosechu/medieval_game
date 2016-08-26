# medieval_game

[![Code Climate](https://codeclimate.com/github/vosechu/medieval_game/badges/gpa.svg)](https://codeclimate.com/github/vosechu/medieval_game)

## Setup

First time:

```
brew update
brew install terminal-notifier
bundle install
```

Check your ruby version, needs to be >= 2.2.5, >= 2.3.1

```
$ ruby -v
ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin15]
```

Installing Rubinius?

```
brew install llvm
ruby-install rbx 3.56
```

## Tests

Run once: `bundle exec rspec`

Run automatically `bundle exec guard`

Run a "full" simulation via `ruby lib/medieval_game.rb`. 

> The full simulation is useful for playing around and to benchmark performance. 
