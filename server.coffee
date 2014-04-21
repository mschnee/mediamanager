
# ==============================================================================
# BASE SETUP
# ------------------------------------------------------------------------------

express    = require "express"
path       = require "path"
fs         = require "fs"
bodyParser = require "body-parser"
port       = process.env.PORT || 3000

app     = express()

# MOUNT MIDDLEWARE
app.use bodyParser()

# ASSETS SETUP
app.use express.static "#{__dirname}/public"

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

app.listen port

console.log "Magic happens on port #{port}"

module.exports = app
