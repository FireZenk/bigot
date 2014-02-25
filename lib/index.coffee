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
							_.each value2, (value3, key3) ->
								partialLoopInner = partialLoopInner.replace "{#{key3}}", value3
							partialLoop = partialLoop + partialLoopInner
						else if _.isArray value2
							console.log "LOG_"+value
							#TODO
						else
							partialLoop = partialLoop + partial.replace "{@}", value2
					sourceEnd = source.slice endPoint, source.length
					sourceIni = source.slice 0, startPoint
					source = sourceIni + partialLoop + sourceEnd.replace "{!#{key}}", ""
			else
				source = source.replace "{#{key}}", value
		return source
		
	return func source, data

###
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
						_.each value2, (value3, key3) ->
							partialLoopInner = partialLoopInner.replace "{@#{key3}}", value3
						partialLoop = partialLoop + partialLoopInner
					if _.isArray value2
						do explore partial, value2
					else
						partialLoop = partialLoop + partial.replace "{@}", value2
				sourceEnd = source.slice endPoint, source.length
				sourceIni = source.slice 0, startPoint
				source = sourceIni + partialLoop + sourceEnd.replace "{!#{key}}", ""
		else
			source = source.replace "{#{key}}", value
###