
# ==============================================================================
# BASE SETUP
# ------------------------------------------------------------------------------

express    = require "express"
path       = require "path"
fs         = require "fs"
bodyParser = require "body-parser"
Datastore  = require "nedb"
# _          = require "lodash" # NOT USING YET...CHECK BACK LATER

app = express()

# ==============================================================================
# API KEYS
# ------------------------------------------------------------------------------

apiKeys = [
  type: "api"
  name: "themoviedb"
  key: "c7de101530406d9ec6d46e8181824f11"
,
  type: "api"
  name: "thetvdb"
  key: "73EF3A7802AFA339"
]

# ==============================================================================
# MOUNT MIDDLEWARE
# ------------------------------------------------------------------------------

app.use bodyParser()

# ==============================================================================
# DATABSE SETUP
# ------------------------------------------------------------------------------

db = new Datastore
  filename: path.join __dirname, "db/mediamanager.db"
  autoload: true

db.ensureIndex fieldName: "type"

# db.insert apiKeys, (err, newDoc) ->
#   console.log "================================================================"
#   console.log newDoc

# db.find { type: "api" }, (err, data) ->
#   data.forEach (value, index, array) ->
#     console.log value.name

# ==============================================================================
# STATIC ASSETS SETUP
# ------------------------------------------------------------------------------

app.use express.static path.join __dirname, "public"

# VIEW SETUP
app.set "views", path.join __dirname, "app/views"
app.set "view engine", "jade"
app.set "view options", { layout: true }

# ==============================================================================
# ROUTES
# ------------------------------------------------------------------------------

routes = require("./config/routes")(app)

# ==============================================================================
# START THE SERVER
# ------------------------------------------------------------------------------

port = process.env.PORT || 3000
app.listen port

console.log "Magic happens on port #{port}"

module.exports = app
