module.exports = (grunt) ->

	# Project configuration.
	grunt.initConfig
		pkg: 
			grunt.file.readJSON 'package.json'
		coffee:
			compile:
				files:
					'./lib/index.js': './lib/index.coffee'
		uglify:
    		target:
      			files:
        			'./lib/index.js': './lib/index.js'

	# Load the plugins
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	# Default task(s)
	grunt.registerTask 'default', ['coffee', 'uglify']