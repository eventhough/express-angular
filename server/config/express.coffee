express = require 'express'
http = require 'http'
path = require 'path'
flash = require 'connect-flash'
liveReload = require 'connect-livereload'

module.exports = (app) ->

  # all environments
  app.set('port', process.env.PORT || 3000)
  # app.set('views', path.join(__dirname + '/../views'))
  # app.set('view engine', 'jade')
  # app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser('s4l3sf0rc3'))
  app.use(express.session())
  app.use(app.router)
  app.use(flash())

  # mount dist folder as highest priority
  app.use(express.static(path.join(__dirname, '../../dist')))

  # development only
  if ('development' == app.get('env'))
    # live reload configuration
    liveReloadPort = 35729
    excludeList = ['.woff', '.flv']

    app.use(liveReload
      port: liveReloadPort
      excludeList: excludeList
    )

    # mount development folders
    app.use(express.static(path.join(__dirname, '../../.tmp')))
    app.use(express.static(path.join(__dirname, '../../app')))

    app.use(express.errorHandler())

  http.createServer(app).listen(app.get('port'), () ->
    console.log('Express server listening on port ' + app.get('port'))
  )
