_ = require 'underscore'
fs = require 'fs'

_isArray = Array.isArray or (obj) -> toString.call obj is '[object Array]'

_isObject = (obj) -> obj is Object obj

_isFunction = (value) -> return typeof value is 'function'

_isString = (value) -> return typeof value is 'string'

_isWindow = (obj) -> return obj and obj.document and obj.location and obj.alert and obj.setInterval

_isArrayLike = (obj) ->
		if obj is null or _isWindow obj
			return false
			length = obj.length
		if obj.nodeType is 1 and length
			return true
		return _isString obj or _isArray obj or length is 0 or typeof length is 'number' and length > 0 and (length - 1) in obj

_expressionComment = new RegExp "{comment [^}]+}","g"

exports.render = (source, data) ->

	renderComments = (source) -> 
		source.replace _expressionComment, ""

	renderIncludes = (source, value, key) -> 
		readed = fs.readFileSync value, "utf-8"
		source.replace "{include #{key}}", readed

	renderHelpers = (source, value, key) ->
		startPoint = source.indexOf "{#{key} "
		sliceStart = source.substring startPoint, source.length
		endPoint = sliceStart.indexOf "}"
		sliceEnd = sliceStart.substring "{#{key} ".length, endPoint
		source.replace "{#{key} #{sliceEnd}}", value.call data["#{sliceEnd}"]

	renderConditionals = (source, value, key) ->
		if value.call()
			source = source.replace "{if #{key}}", ""
			startPoint = source.lastIndexOf "{else}"
			endPoint = source.indexOf("{end #{key}}")+ 6 + "#{key}".length
			source = source.replace source.slice(startPoint, endPoint), ""
		else
			startPoint = source.indexOf "{if #{key}}"
			endPoint = source.lastIndexOf("{else}") + 6
			source = source.replace source.slice(startPoint, endPoint), ""
			source = source.replace "{end #{key}}", ""

	renderLoops = (source, value, key) ->
		startPoint = source.indexOf "{loop #{key}}"
		if startPoint isnt undefined
			startPoint2 = 7 + startPoint + "#{key}".length
			endPoint = source.indexOf "{end #{key}}"
			partial = source.slice startPoint2, endPoint
			partialLoop = ""
			_.each value, (value2, key2) -> # need to remove underscore
				if _isObject value2
					partialLoopInner = partial
					_.each value2, (value3, key3) -> # need to remove underscore
						if _isArray value3
							startPointInner = partialLoopInner.indexOf "{loop #{key3}}"
							endPointInner = 6 + (partialLoopInner.indexOf "{end #{key3}}") + "#{key3}".length
							innerArray = func partialLoopInner.slice(startPointInner,endPointInner), value2
							partialLoopInner =
								partialLoopInner.slice(0, startPointInner) + innerArray + 
								partialLoopInner.slice(endPointInner, partial.length)
						else
							partialLoopInner = partialLoopInner.replace "{#{key3}}", value3
					partialLoop = partialLoop + partialLoopInner
				else
					partialLoop = partialLoop + partial.replace "{@}", value2
			sourceEnd = source.slice endPoint, source.length
			sourceIni = source.slice 0, startPoint
			sourceIni + partialLoop + sourceEnd.replace "{end #{key}}", ""

	# MAIN
	func = (source, data) ->
		_.each data, (value, key) -> # need to remove underscore
			# COMMENTS
			if _expressionComment.test source
				source = renderComments source
			# INCLUDES
			if (source.indexOf "{include #{key}}") isnt -1
				return source = renderIncludes source, value, key
			# HELPERS
			if (source.indexOf "{#{key} ") isnt -1
				return source = renderHelpers source, value, key
			# CONDITIONALS
			if (source.indexOf "{if #{key}}") isnt -1
				return source = renderConditionals source, value, key
			# LOOPS
			if _isArray value
				return source = renderLoops source, value, key
			else
				return source = source.replace "{#{key}}", value
		return source
	return func source, data