
angular
  .module "BrowserApp"
  .controller "BrowserCtrl", ($scope) ->
    $pathsContainer = $("#paths-container")

    button =
      $reset: $("#button-reset")
      $test:  $("#button-test")
      $directories: $("button.directory")

    $pathsContainer.on "click", "button.directory", (event) ->
      path = getPathFromButton event.target
      getDirectories path

    button.$reset.on "click", ->
      resetDirectories()
      $scope.$apply()

    button.$test.on "click", ->
      getDirectories()

    $scope.directories = []

    $scope.current =
      directory:
        path: " "
        name: " "
        parentPath: null
        parentName: null

    getPathFromButton = (button) ->
      $(button)
        .removeData('path')
        .data('path')

    updateDirectories = (dirs) ->
      resetDirectories()
      dirs.forEach (value, index, array) ->
        directory = value
        $scope.directories[index] =
          name: directory.name
          path: directory.path

    updateCurrentPath = (path) ->
      if path
        nameStart = path.lastIndexOf "/"
        name = path.substr nameStart + 1, path.length - 1
        $scope.current.directory.path = path
        $scope.current.directory.name = name

    updateCurrentParent = (parentPath) ->
      if parentPath
        parentNameStart = parentPath.lastIndexOf "/"
        parentName = parentPath.substr parentNameStart + 1, parentPath.length - 1
        $scope.current.directory.parentPath = parentPath
        $scope.current.directory.parentName = parentName

    resetDirectories = ->
      $scope.directories = []
      $scope.current.directory.path = " "
      $scope.current.directory.name = " "
      $scope.current.directory.parentPath = null
      $scope.current.directory.parentName = null

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

