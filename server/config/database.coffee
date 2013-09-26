# Initialize the models
require './../models'

DATABASE_URI = process.env.MONGOLAB_URI || 'mongodb://localhost'
DATABASE_NAME = '/test'
MONGODB = DATABASE_URI + DATABASE_NAME

# Connnect to the database
mongoose = require 'mongoose'
mongoose.connect MONGODB

db = mongoose.connection
db.on 'error', console.error.bind console, 'Database error:'
db.once 'open', () ->
  console.log 'Database connected'

module.exports = db
