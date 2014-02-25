_ = require 'underscore'

exports.compile = compile = (source, data) ->
	_.each data, (value, key, list) ->
		source = source.replace "{#{key}}", value
	return source