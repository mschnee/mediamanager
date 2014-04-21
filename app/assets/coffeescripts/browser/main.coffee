
angular
  .module "BrowserApp"
  .controller "BrowserCtrl", ($scope) ->

    # _dirs = [
    #   "/mnt/base/media/movies"
    #   "/mnt/tank/media/tv"
    #   "/mnt/tank/downloads"
    # ]

    # _test = [
    #   "/mnt/base/test"
    # ]

    $pathsContainer = $("#paths-container")
    button =
      $reset: $("#button-reset")
      $test:  $("#button-test")
      $directories:     $("button.directory")

    $pathsContainer
      .on "click", button.$directories, (event) ->
        path = getPathFromButton event.target
        console.log path
        getDirectories path
        # $scope.$apply()

    button.$reset
      .on "click", ->
        resetDirectories()
        $scope.$apply()

    button.$test
      .on "click", ->
        getDirectories()

    $scope.directories = []

    $scope.current =
      directory:
        path: null
        parent: null

    getPathFromButton = (button) ->
      $(button).removeData('path')
      $(button).data('path')

    updateDirectories = (dirs) ->
      resetDirectories()
      dirs.forEach (value, index, array) ->
        directory = value
        $scope.directories[index] =
          name: directory.name
          path: directory.path

    updateCurrentPath = (path) ->
      $scope.current.directory.path = path if path

    updateCurrentParent = (parent) ->
      $scope.current.directory.parent = parent if parent

    resetDirectories = ->
      $scope.directories = []
      $scope.current.directory.path = null
      $scope.current.directory.parent = null

    # updateDirectories(_test)

    getDirectories = (path) ->
      _data = "path": path
      $.ajax
        url: "/directories"
        type: "POST"
        contentType: "application/json"
        dataType: "json"
        data: JSON.stringify _data
        success: (data) ->
          updateDirectories(data.dirs)
          updateCurrentPath(path)
          updateCurrentParent(data.parent)
          $scope.$apply()

