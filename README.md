# grunt-didumean

> Display possible typos in your code

**grunt-didumean** help you find terms in your files, like typos or error you do often.

At this time, you need to reference the terms yourself, but I hope adding some default terms, langage-based, in the future.

* * *

## Getting Started
This plugin requires Grunt `~0.4.3`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-didumean --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-didumean');
```

## The "didumean" task

### Overview
In your project's Gruntfile, add a section named `didumean` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  didumean: {
    options: {
      // Task-specific options go here.
    },
    your_target: {
      // Target-specific file lists and/or options go here.
    },
  },
});
```

### Options

#### options.terms
Type: `Object`  
Default value: `null`

A hash of key values, where the key is the correct term, the value is a `String` or a `RegExp` to search.  
If you give a `String`, it will be converted as a `RegExp` with the `case insensitive` (`i`) flag.  
Look at the example below. :)

### Usage Examples

```js
grunt.initConfig({
  todo: {
    options: {
      terms: {
        "length": /lenght/,
        "constructor": /constuctor/,
        "todo": "tood"
      }
    },
    src: [
      'test/*'
    ],
  },
});
```

Will return you the files where you spelled "*lenght*" instead of "*length*", "*constuctor*" instead of "*constructor*" and "*tood*" instead of "*todo*" (this one will be `case insensitive`).

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

## Release History

* **2014/04/08** : v0.1.0

## TODO

* Add levenstein-based search mode
* Add default search terms for common langages
* Writing Unit tests ;)
