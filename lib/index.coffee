_ = require 'underscore'
fs = require 'fs'

exports.render = (source, data) ->

	func = (source, data) ->
		_.each data, (value, key) ->
			if (source.indexOf "{include #{key}}") isnt -1
				readed = fs.readFileSync value, "utf-8"
				return source = source.replace "{include #{key}}", readed
			if _.isArray value
				startPoint = source.indexOf "{loop #{key}}"
				if startPoint isnt undefined
					startPoint2 = 7 + startPoint + "#{key}".length
					endPoint = source.indexOf "{end #{key}}"
					partial = source.slice startPoint2, endPoint
					partialLoop = ""
					_.each value, (value2, key2) ->
						if _.isObject value2
							partialLoopInner = partial
							_.each value2, (value3, key3, list) ->
								if _.isArray value3
									startPointInner = partialLoopInner.indexOf "{loop #{key3}}"
									endPointInner = 6 + (partialLoopInner.indexOf "{end #{key3}}") + "#{key3}".length
									innerArray = func partialLoopInner.slice(startPointInner,endPointInner), value2
									partialLoopInner =
										partialLoopInner.slice(0, startPointInner) + innerArray + partialLoopInner.slice(endPointInner, partial.length)
								else
									partialLoopInner = partialLoopInner.replace "{#{key3}}", value3
							partialLoop = partialLoop + partialLoopInner
						else
							partialLoop = partialLoop + partial.replace "{@}", value2
					sourceEnd = source.slice endPoint, source.length
					sourceIni = source.slice 0, startPoint
					return source = sourceIni + partialLoop + sourceEnd.replace "{end #{key}}", ""
			else
				return source = source.replace "{#{key}}", value
		return source

	return func source, data
