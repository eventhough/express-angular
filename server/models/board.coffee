mongoose = require('mongoose')
Schema = mongoose.Schema

# Board Schema

boardSchema = Schema
  name :
    type: String 
    required: true 
  query : 
    type: String 
    required: true
  _owner  :
    type: Schema.Types.ObjectId
    ref: 'User'
  services : 
    twitter: Boolean 
    instagram: Boolean
    chatter: Boolean
  created_date :
    type: Date 
    required: true 
  colorScheme : 
    type: String
    required: true # light or dark right now


module.exports = mongoose.model('Board', boardSchema)
