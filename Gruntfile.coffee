###
 * grunt-didumean
 * https://github.com/leny/grunt-didumean
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
###

"use strict"

module.exports = ( grunt ) ->

  grunt.initConfig
    jshint:
      all: [
        "tasks/*.js"
      ]
      options:
        jshintrc: ".jshintrc"

    coffee:
      bin:
        expand: yes
        cwd: "lib/"
        src: [ "**/*.coffee" ]
        dest: "tasks/"
        ext: ".js"
        options:
          bare: yes

    didumean:
      simple:
        options:
          terms:
            "length": /lenght/
            "constructor": /constuctor/
            "todo": /tood/
        src: [
          "test/*"
        ]

  grunt.loadTasks "tasks"

  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-coffee"

  grunt.registerTask "default", [
    "coffee"
    "jshint"
    "didumean"
  ]

