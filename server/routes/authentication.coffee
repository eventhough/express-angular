mongoose = require 'mongoose'
User = mongoose.model('User')

module.exports = (app, passport) ->

  login = (req, res, next) ->
    passport.authenticate('local', (err, user, info) ->
      if err
        console.error 'auth error'
        return next(err)
      if !user
        req.session.messages =  [info.message]
        return res.redirect('/')

      req.logIn(user, (err) ->
        if err
          console.error 'login error'
          return next(err)
        return res.redirect('/account')
      )
    )(req, res, next)

  logout = (req, res) ->
    req.logout()
    res.redirect '/'

  app.post '/login', login
  app.post '/logout', logout
