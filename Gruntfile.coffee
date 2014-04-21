module.exports = (grunt) ->

  grunt.initConfig
  # ============================================================================
  # TASK CONFIGURATION
  # ----------------------------------------------------------------------------
    autoprefixer:
      compile:
        options:
          browsers: ["last 2 version"]
          cascade: true
        files: [
          expand: true
          cwd:  "public/assets/css"
          src:  ["main.css"]
          dest: "public/assets/css"
        ]
    coffee:
      # compile:
      compileBare:
        options:
          bare: true
          sourceMap: true
        files: [
          expand: true
          cwd:  "app/assets/coffeescripts"
          src:  ["**/*.coffee"]
          dest: "public/assets/js"
          ext:  ".js"
        ]
    stylus:
      compile:
        # files: [
        #   expand: true
        #   cwd:  "app/assets/stylus"
        #   src:  ["**/*.styl"]
        #   dest: "public/assets/css"
        #   ext:  ".css"
        # ]
        options:
          compress: false
        files:
          "public/assets/css/main.css": "app/assets/stylus/main.styl"
  # ============================================================================
  # WATCH CONFIGURATION
  # ----------------------------------------------------------------------------
    watch:
      coffeescripts:
        tasks: ["coffee"]
        files: ["app/assets/coffeescripts/**/*.coffee"]
      gruntfile:
        options:
          reload: true
        files: "Gruntfile.coffee"
      javascripts:
        options:
          livereload: true
        files: ["public/assets/js/**/*.js"]
      stylesheets:
        options:
          livereload: true
        files: ["public/assets/css/main.css"]
      stylus:
        tasks: ["stylus", "autoprefixer"]
        files: ["app/assets/stylus/**/*.styl"]


  grunt.loadNpmTasks "grunt-autoprefixer"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", ["watch"]
