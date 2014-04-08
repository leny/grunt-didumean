###
 * grunt-didumean
 * https://github.com/leny/grunt-didumean
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
###

"use strict"

chalk = require "chalk"
table = require "text-table"

module.exports = ( grunt ) ->

    grunt.registerMultiTask "didumean", "Display possible typos in your code", ->

        aSimpleMarks = []

        if @options().terms
            for sName, rPattern of @options().terms
                aSimpleMarks.push
                    name: sName
                    regex: if ( rPattern instanceof RegExp ) then rPattern else new RegExp rPattern, "gi"

        @filesSrc
            .filter ( sFilePath ) ->
                grunt.file.exists( sFilePath ) and grunt.file.isFile( sFilePath )
            .forEach ( sFilePath ) ->
                aResults = []
                grunt.file
                    .read sFilePath
                    .split /\r*\n/
                    .map ( sLine, iIndex ) ->
                        aSimpleMarks.forEach ( oMark ) ->
                            if aResult = oMark.regex.exec sLine
                                sDisplayLine = sLine.substring 0, aResult.index
                                sDisplayLine += chalk.bold.red sLine.substring aResult.index, aResult.index + aResult[ 0 ].length
                                sDisplayLine += sLine.substring aResult.index + aResult[ 0 ].length

                                aResults.push [
                                    chalk.gray "\t• line #{ iIndex + 1 }"
                                    chalk.cyan( "Did you mean " ) + chalk.yellow( oMark.name ) + chalk.cyan( " ?" )
                                    chalk.white.italic sDisplayLine.trim()
                                ]
                if aResults.length
                    grunt.log.writeln()
                    grunt.log.writeln "\t" + chalk.underline sFilePath
                    grunt.log.writeln()
                    grunt.log.writeln table aResults

