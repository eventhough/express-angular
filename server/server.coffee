# Module dependencies.
express = require 'express'
passport = require 'passport'

# Connect to DB
db = require './config/database'

# App initialization and configuration
app = express()
require('./config/express')(app)

#Authentication middleware
#require('./config/passport')(app, passport)

# Mount routes
require('./routes')(app, passport)
