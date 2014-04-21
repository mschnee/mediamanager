fs   = require "fs"
path = require "path"

module.exports = (app) ->

# ==============================================================================
# ROUTER MIDDLEWARE
# ------------------------------------------------------------------------------

  app.use (req, res, next) ->
    # LOG EACH REQUEST TO THE CONSOLE
    console.log req.method, req.url
    # GO TO THE NEXT THING
    next()

  app.param "name", (req, res, next, name) ->
    # DO VALIDATION
    # LOG SOMETHING
    console.log "doing custom validation on #{name}"
    # ONCE VALIDATION IS DONE SAVE THE NEW ITEM IN THE REQ
    req.name = name + "  oooo"
    # GO TO THE NEXT THING
    next()

# ==============================================================================
# ROUTES
# ------------------------------------------------------------------------------

  app.route "/"
    .get (req, res) ->
      console.log "Hit the index page, I think. #{foo}"
      res.send "This is the index root home page. Whatever."

  app.route "/sample"
    .get (req, res) ->
      res.send "this is a sample!"

  app.route "/name/:name"
    .get (req, res) ->
      res.send "hello #{req.name}!!!"

  app.route "/directories"
    .post (req, res) ->
      _path = req.body.path or "#{path.sep}"
      data =
        dirs: []
        parent: "#{path.sep}"
        is_root: false
        home: "/nonexistant/"
        empty: true
      if _path is path.sep
        data.is_root = true
        data.parent  = false
      fs.readdir _path, (err, files) ->
        data.empty = false
        data.parent = path.dirname _path unless data.parent is false
        files.map (file) ->
          stats = fs.statSync "#{_path}"
          if stats.isDirectory() and not file.match /\./
            fullPath = if "#{_path}" isnt "#{path.sep}"
            then "#{_path}#{path.sep}#{file}"
            else "#{path.sep}#{file}"
            data.dirs.push
              path: fullPath
              name: file
        res.json data

  app.route "/browser"
    .get (req, res) ->
      fs.readdir "/", (err, files) ->
        unless err
          res.render "browser/browser", { files: files }
