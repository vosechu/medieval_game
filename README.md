# medieval_game

[![Code Climate](https://codeclimate.com/github/vosechu/medieval_game/badges/gpa.svg)](https://codeclimate.com/github/vosechu/medieval_game)
[Project board](trello.com/b/SryuBsI8/david-and-my-game)

## Dependencies

Check your ruby version, needs to be >= 2.2.5, >= 2.3.1

```
$ ruby -v
ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]
```

If you aren't at 2.2.5+ or 2.3.1+

```
ruby-install ruby 2.3.1
# Reboot shell
cd <source directory>
gem install bundler
```

Installing Rubinius?

```
brew install llvm
ruby-install rbx 3.56
# Reboot shell
cd <source directory>
chruby rbx
```

Installing jRuby?

```
# Install the Java JDK (not the runtime) from http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
ruby-install jruby
# Reboot shell
cd <source directory>
chruby jruby
gem install bundler
```

## First time setup

```
brew update
brew install terminal-notifier
bundle install
```

## Tests

Run once: `bundle exec rspec`

Run automatically and notify: `bundle exec guard`

> This will communicate with you via the system notifications in OS X. This will let you stay in your editor full-time.

Run a "full" simulation: `time bundle exec ruby lib/medieval_game.rb`.
Run a "full" simulation (w/o contract analysis): `time NO_CONTRACTS=true bundle exec ruby lib/medieval_game.rb`.
Run a "full" simulation (w/o massive log output): `time bundle exec ruby lib/medieval_game.rb 2>&1 | grep WARN`.


> The full simulation is useful for playing around and to benchmark performance.
