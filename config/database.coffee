
fs   = require "fs"
path = require "path"
Datastore = require "nedb"

module.exports = (app) ->

  db = new Datastore
    filename: path.join __dirname, "db/mediamanager.db"

