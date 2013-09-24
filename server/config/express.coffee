express = require 'express'
http = require 'http'
path = require 'path'
flash = require 'connect-flash'
liveReload = require 'connect-livereload'

module.exports = (app) ->

  # all environments
  app.set('port', process.env.PORT || 3000)
  app.use(express.favicon())
  app.use(express.logger())
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser('P03t1cJu5t1c3'))
  app.use(express.session({ secret: 'K3ndr1ckLamar', key: 'sid', cookie: { secure: true }}))
  app.use(app.router)
  app.use(flash())

  # development only
  if ('development' == process.env.NODE_ENV)
    # live reload configuration for grunt
    liveReloadPort = 35729
    excludeList = ['.woff', '.flv']

    app.use(liveReload
      port: liveReloadPort
      excludeList: excludeList
    )

    # mount development folders
    app.use(express.static(path.join(__dirname, '../../.tmp')))
    app.use(express.static(path.join(__dirname, '../../app')))
    app.use(express.static(path.join(__dirname, '../../test')))

    app.use(express.errorHandler)

  # mount all static files (html, css, js)
  app.use(express.static(path.join(__dirname, '../../dist')))

  http.createServer(app).listen(app.get('port'), () ->
    console.log('Express server listening on port ' + app.get('port'))
  )
