mongoose = require('mongoose')
Schema = mongoose.Schema

# Message Schema

messageSchema = Schema
  subject      : { type: String, required: true}
  object   : { type: Schema.Types.Mixed, required: true} # this can store the object itself
  action    : { type: String, required: true} # create, update, delete
  created_date : { type: Date, required: true }

  ,
    capped:
      size : 200000
      max : 1000

module.exports = mongoose.model('Message', messageSchema)
