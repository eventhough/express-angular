mongoose = require 'mongoose'
Schema = mongoose.Schema
bcrypt   = require 'bcrypt'
utils = require './../lib/utils'
SALT_WORK_FACTOR = 10

# User Schema
userSchema = Schema
  username:
    type: String
    required: true
    unique: true
  email:
    type: String
    required: true
    unique: true
  password:
    type: String
    required: true
  accessToken: # used for Remember Me
    type: String

# Bcrypt middleware
userSchema.pre('save', (next) ->
  user = this

  if !user.isModified('password')
    return next()

  bcrypt.genSalt(SALT_WORK_FACTOR, (err, salt) ->
    if (err)
      return next(err)

    bcrypt.hash(user.password, salt, (err, hash) ->
      if(err)
        return next(err)
      user.password = hash
      next()
    )
  )
)

# Password verification
userSchema.methods.comparePassword = (candidatePassword, callback) ->
  bcrypt.compare(candidatePassword, this.password, (err, isMatch) ->
    if err
      return callback(err)
    callback(null, isMatch)
  )

module.exports = mongoose.model('User', userSchema)
