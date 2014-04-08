
/*
 * grunt-didumean
 * https://github.com/leny/grunt-didumean
 *
 * Copyright (c) 2014 Leny
 * Licensed under the MIT license.
 */
"use strict";
var chalk, table;

chalk = require("chalk");

table = require("text-table");

module.exports = function(grunt) {
  return grunt.registerMultiTask("didumean", "Display possible typos in your code", function() {
    var aSimpleMarks, rPattern, sName, _ref;
    aSimpleMarks = [];
    if (this.options().terms) {
      _ref = this.options().terms;
      for (sName in _ref) {
        rPattern = _ref[sName];
        aSimpleMarks.push({
          name: sName,
          regex: rPattern instanceof RegExp ? rPattern : new RegExp(rPattern, "gi")
        });
      }
    }
    return this.filesSrc.filter(function(sFilePath) {
      return grunt.file.exists(sFilePath) && grunt.file.isFile(sFilePath);
    }).forEach(function(sFilePath) {
      var aResults;
      aResults = [];
      grunt.file.read(sFilePath).split(/\r*\n/).map(function(sLine, iIndex) {
        return aSimpleMarks.forEach(function(oMark) {
          var aResult, sDisplayLine;
          if (aResult = oMark.regex.exec(sLine)) {
            sDisplayLine = sLine.substring(0, aResult.index);
            sDisplayLine += chalk.bold.red(sLine.substring(aResult.index, aResult.index + aResult[0].length));
            sDisplayLine += sLine.substring(aResult.index + aResult[0].length);
            return aResults.push([chalk.gray("\t• line " + (iIndex + 1)), chalk.cyan("Did you mean ") + chalk.yellow(oMark.name) + chalk.cyan(" ?"), chalk.white.italic(sDisplayLine.trim())]);
          }
        });
      });
      if (aResults.length) {
        grunt.log.writeln();
        grunt.log.writeln("\t" + chalk.underline(sFilePath));
        grunt.log.writeln();
        return grunt.log.writeln(table(aResults));
      }
    });
  });
};
