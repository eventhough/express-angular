middleware = require './middleware'

module.exports = (app, passport) ->
  require('./authentication')(app, passport)
  require('./user')(app)
