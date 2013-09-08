# salesforce.com splashboard

Displays live social media posts on various display formats.

## Global Dependencies

Install [mongodb](http://www.mongodb.org/downloads).

Install [node.js](http://nodejs.org) and then open Terminal:

    npm install -g node-dev
    npm install -g bower

## Project Setup

    fork project
    clone project
    $ cd project/
    $ npm install
    $ bower install
    $ mongod (first tab)
    $ node-dev server/server.coffee (second tab)
    $ grunt server (third tab)

## Testing

n/a

Open [localhost:9000](http://localhost:9000)

You can lint the javascript and CoffeeScript code using:

    $ grunt lint

The config can be changed in `./jshintrc` and `./coffeelintrc`.

## Sublime Text 2

- install [Package Control](https://sublime.wbond.net/installation)
- install EditorConfig with Package Control (cmd-shift-P)

## Links

n/a
