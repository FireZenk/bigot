_ = require 'underscore'

exports.render = (source, data) ->

	func = (source, data) ->
		_.each data, (value, key) ->
			if _.isArray value
				startPoint = source.indexOf "{¡#{key}}"
				if startPoint != undefined
					startPoint2 = 3 + startPoint + "#{key}".length
					endPoint = source.indexOf "{!#{key}}"
					partial = source.slice startPoint2, endPoint
					partialLoop = ""
					_.each value, (value2, key2) ->
						if _.isObject value2
							partialLoopInner = partial
							_.each value2, (value3, key3, list) ->
								if _.isArray value3
									startPointInner = partialLoopInner.indexOf "{¡#{key3}}"
									endPointInner = 3 + (partialLoopInner.indexOf "{!#{key3}}") + "#{key3}".length
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
					return source = sourceIni + partialLoop + sourceEnd.replace "{!#{key}}", ""
			else
				return source = source.replace "{#{key}}", value
		return source
		
	return func source, data