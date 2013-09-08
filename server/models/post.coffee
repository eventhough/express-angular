mongoose = require('mongoose')
Schema = mongoose.Schema

# Post Schema

postSchema = new Schema
	id :
		type: String
	text:
		type: String
	image_url:
		type: String
	created_date:
		type: Date
	user:
		id:
			type: String
		screen_name:
			type: String
		name:
			type: String
		location:
			type: String
		description:
			type: String
		profile_image:
			type: String
		profile_background_image:
			type: String
	source:
		type: String

	tagged:
		type: Boolean

	tags:
		[type: String]
,
	capped:
		size : 5242880
		max : 1000000

module.exports = mongoose.model('Post', postSchema)