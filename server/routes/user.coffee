mongoose = require 'mongoose'
User = mongoose.model('User')

module.exports = (app, middleware, passport) ->
  createUser = (req, res, next) ->
    user = new User req.body.user
    console.log user
    user.save (err) ->
      if err
        console.error err
        req.flash('error', err.message)
        res.redirect('/')
      else
        console.log('user: ' + user.name + " saved.")
        req.logIn user, (err) ->
          if err
            return next(err)
          res.redirect('/account')

  readUser = (req, res, next) ->

  updateUser = (req, res, next) ->

  deleteUser = (req, res, next) ->

  app.post '/user', createUser
  app.get '/user', readUser
