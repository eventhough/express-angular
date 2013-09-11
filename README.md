# Express + Angular Skeleton

Project originally based on Yeoman. Added support for MongoDB and watching of coffeescript, jade, and stylus files.

## Global Dependencies

Install [mongodb](http://www.mongodb.org/downloads).

Install [node.js](http://nodejs.org) then open Terminal:

    npm install -g node-dev
    npm install -g bower
    npm install -g grunt-cli

## Project Setup

    Add to .bash_profile or .bashrc: export NODE_ENV=development
    fork project
    clone project
    $ cd project/
    $ npm install
    $ bower install
    $ mongod (first tab)
    $ node-dev server/server.coffee (second tab)
    $ grunt server (third tab)

## Development

Open [localhost:3000](http://localhost:3000)

Lint your javascript and coffeescript using:

    $ grunt lint

Lint config can be changed in `./jshintrc` and `./coffeelintrc`.

## Heroku Deployment

    Nothing here yet

## Sublime Text 2

- install [Package Control](https://sublime.wbond.net/installation)
- install EditorConfig with Package Control (cmd-shift-P)

## Links

n/a
