steroids = require "../../../steroids"
spawn = require("child_process").spawn
path = require "path"
fs = require "fs"
ejs = require "ejs"
util = require "util"

Base = require "../Base"

class Default extends Base
  @usageParams: ->
    "<resource>"

  @usage: ()->
    """
    Generates a stub resource consisting of a controller and index show views.

    Options:
      - resource: name of resource to use. example: car will result in a app/controllers/car.js and views/car/index.html & show.html
    """

  templatePath: ->
    path.join(steroids.paths.templates.resources, "default")

  generate: ->
    @checkForPreExistingFiles [
      path.join("app", "controllers", "#{@options.name}.js"),
      path.join("app", "models", "#{@options.name}.js"),
      path.join("app", "views", "#{@options.name}", "index.html"),
      path.join("app", "views", "#{@options.name}", "show.html")
    ]

    @ensureDirectory path.join("app")
    
    @ensureDirectory path.join("app", "controllers")
    @copyFile path.join("app", "controllers", "application.js"), "application_controller.js.template"
    @addFile path.join("app", "controllers", "#{@options.name}.js"), "controller.js.template"
    
    @ensureDirectory path.join("app", "models")
    @addFile path.join("app", "models", "#{@options.name}.js"), "model.js.template"

    @ensureDirectory path.join("app", "views")
    
    @ensureDirectory path.join("app", "views", "layouts")
    @copyFile path.join("app", "views", "layouts", "application.html"), "layout.html.template"
    
    @ensureDirectory path.join("app", "views", "#{@options.name}")

    @addFile path.join("app", "views", "#{@options.name}", "index.html"), "index.html.template"
    @addFile path.join("app", "views", "#{@options.name}", "show.html"), "show.html.template"

    util.log "Command completed successfully."


module.exports = Default
