'use strict'

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'

module.exports = (grunt) ->
  # load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # configurable paths
  yeomanConfig =
    app: 'app'
    server: 'server'
    dist: 'dist'
    liveReloadPort: 35729
    connectPort: 3000

  preprocessOptions =
    event: ['added', 'changed']
    nospawn: true
    livereload: yeomanConfig.liveReloadPort

  try
    yeomanConfig.app = require('./bower.json').appPath or yeomanConfig.app
  catch e

  grunt.initConfig
    yeoman: yeomanConfig
    watch:
      coffee:
        options: preprocessOptions
        files: ['<%= yeoman.app %>/scripts/{,*/}*.coffee', 'test/spec/{,*/}*.coffee']
        tasks: ['coffee:single']

      jade:
        options: preprocessOptions
        files: ['<%= yeoman.app %>/*.jade', '<%= yeoman.app %>/views/{,*/}*.jade']
        tasks: ['jade:single']

      stylus:
        options: preprocessOptions
        files: ['<%= yeoman.app %>/styles/{,*/}*.styl']
        tasks: ['stylus:single']

      livereload:
        options:
          livereload: '<%= yeoman.liveReloadPort %>'
        files: ['{.tmp,<%= yeoman.app %>}/{,*/}*.html', '{.tmp,<%= yeoman.app %>}/views/{,*/}*.html', '{.tmp,<%= yeoman.app %>}/styles/{,*/}*.css', '{.tmp,<%= yeoman.app %>}/scripts/{,*/}*.js', '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}']

    open:
      server:
        url: 'http://localhost:<%= yeoman.connectPort %>'

    clean:
      dist:
        files: [
          dot: true
          src: ['.tmp', '<%= yeoman.dist %>/*', '!<%= yeoman.dist %>/.git*']
        ]
      server: '.tmp'

    jshint:
      options: jshintrc: '.jshintrc'
      app: ['Gruntfile.js', '<%= yeoman.app %>/scripts/{,*/}*.js']
      server: ['<%= yeoman.server %>/**/*.js']

    coffeelint:
      options: grunt.file.readJSON('.coffeelintrc')
      app: ['Gruntfile.coffee', '<%= yeoman.app %>/scripts/{,*/}*.coffee']
      server: ['<%= yeoman.server %>/**/*.coffee']

    coffee:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/scripts'
          src: '{,*/}*.coffee'
          dest: '.tmp/scripts'
          ext: '.js'
        ]
      test:
        files: [
          expand: true
          cwd: 'test/spec'
          src: '{,*/}*.coffee'
          dest: '.tmp/spec'
          ext: '.js'
        ]
      single:
        src: ''
        dest: ''

    jade:
      options:
        pretty: true
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>'
          src: '*.jade'
          dest: '.tmp'
          ext: '.html'
        ,
          expand: true
          cwd: '<%= yeoman.app %>/views'
          src: '{,*/}*.jade'
          dest: '.tmp/views'
          ext: '.html'
        ]
      single:
        src: ''
        dest: ''

    stylus:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/styles'
          src: '{,*/}*.styl'
          dest: '.tmp/styles'
          ext: '.css'
        ]
      single:
        src: ''
        dest: ''

    browserify:
      options:
        noParse: ['angular', 'Packery']
        debug: true
        transform: ['coffeeify']
        shim:
          angular:
            path: '<%= yeoman.app %>/bower_components/angular/angular.js'
            exports: 'angular'
          Packery:
            path: '<%= yeoman.app %>/vendor/packery/packery.pkgd.js'
            exports: 'Packery'
      server:
        src: '<%= yeoman.app %>/scripts/app.coffee'
        dest: '.tmp/scripts/modules.js'
      dist:
        src: '<%= yeoman.app %>/scripts/app.coffee'
        dest: '<%= yeoman.dist %>/scripts/modules.js'


    # not used since Uglify task does concat,
    # but still available if needed
    #concat: {
    #      dist: {}
    #    },
    rev:
      dist:
        files:
          src: ['<%= yeoman.dist %>/scripts/{,*/}*.js', '<%= yeoman.dist %>/styles/{,*/}*.css', '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}', '<%= yeoman.dist %>/styles/fonts/*']

    useminPrepare:
      #html: '<%= yeoman.app %>/index.html',
      html: '.tmp/index.html'
      options:
        dest: '<%= yeoman.dist %>'

    usemin:
      html: ['<%= yeoman.dist %>/{,*/}*.html']
      css: ['<%= yeoman.dist %>/styles/{,*/}*.css']
      options:
        dirs: ['<%= yeoman.dist %>']

    imagemin:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/images'
          src: '{,*/}*.{png,jpg,jpeg}'
          dest: '<%= yeoman.dist %>/images'
        ]

    svgmin:
      dist:
        files: [
          expand: true
          cwd: '<%= yeoman.app %>/images'
          src: '{,*/}*.svg'
          dest: '<%= yeoman.dist %>/images'
        ]

    cssmin: {}

    # By default, your `index.html` <!-- Usemin Block --> will take care of
    # minification. This option is pre-configured if you do not wish to use
    # Usemin blocks.
    # dist: {
    #   files: {
    #     '<%= yeoman.dist %>/styles/main.css': [
    #       '.tmp/styles/{,*/}*.css',
    #       '<%= yeoman.app %>/styles/{,*/}*.css'
    #     ]
    #   }
    # }
    htmlmin:
      dist:
        options: {}
        #removeCommentsFromCDATA: true,
        #          // https://github.com/yeoman/grunt-usemin/issues/44
        #          //collapseWhitespace: true,
        #          collapseBooleanAttributes: true,
        #          removeAttributeQuotes: true,
        #          removeRedundantAttributes: true,
        #          useShortDoctype: true,
        #          removeEmptyAttributes: true,
        #          removeOptionalTags: true
        files: [
          expand: true
          cwd: '.tmp'
          src: ['*.html', 'views/*.html']
          dest: '<%= yeoman.dist %>'
        ]

    # Put files not handled in other tasks here
    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: '<%= yeoman.app %>'
          dest: '<%= yeoman.dist %>'
          src: ['*.{ico,png,txt}', '.htaccess', 'bower_components/**/*', 'images/{,*/}*.{gif,webp}', 'styles/fonts/*']
        ,
          expand: true
          cwd: '.tmp/images'
          dest: '<%= yeoman.dist %>/images'
          src: ['generated/*']
        ]

    concurrent:
      server: ['coffee:dist', 'jade:dist', 'stylus:dist']
      test: ['coffee:dist', 'coffee:test']
      dist: ['coffee:dist', 'jade:dist', 'stylus:dist', 'imagemin', 'svgmin']

    karma:
      unit:
        configFile: 'karma.conf.js'
        singleRun: true

    cdnify:
      dist:
        html: ['<%= yeoman.dist %>/*.html']

    uglify:
      dist:
        files:
          '<%= yeoman.dist %>/scripts/modules.js': ['<%= yeoman.dist %>/scripts/modules.js']

  grunt.event.on 'watch', (action, filepath, target) ->
    ext = ''
    switch target
      when 'coffee'
        ext = '.js'
      when 'jade'
        ext = '.html'
      when 'stylus'
        ext = '.css'
    dest = '.tmp' + filepath.substring(filepath.indexOf('/'), filepath.lastIndexOf('.')) + ext
    grunt.config.set target + '.single.src', filepath
    grunt.config.set target + '.single.dest', dest

  grunt.registerTask 'server', (target) ->
    return grunt.task.run(['build', 'open']) if target is 'dist'
    grunt.task.run ['clean', 'concurrent:server', 'open', 'watch']

  grunt.registerTask 'test', ['clean', 'concurrent:test', 'karma']

  grunt.registerTask 'build', ['clean:dist', 'concurrent:dist', 'useminPrepare', 'htmlmin', 'concat', 'copy', 'cdnify', 'cssmin', 'uglify', 'rev', 'usemin']

  grunt.registerTask 'lint', (target) ->
    return ['jshint:app', 'coffeelint:app'] if target is 'app'
    return ['jshint:server', 'coffeelint:server'] if target is 'server'
    grunt.task.run ['jshint', 'coffeelint']

  grunt.registerTask 'default', ['jshint', 'coffeelint', 'test', 'build']