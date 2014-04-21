angular.module("BrowserApp").controller("BrowserCtrl", function($scope) {
  var $pathsContainer, button, getDirectories, getPathFromButton, resetDirectories, updateCurrentParent, updateCurrentPath, updateDirectories;
  $pathsContainer = $("#paths-container");
  button = {
    $reset: $("#button-reset"),
    $test: $("#button-test"),
    $directories: $("button.directory")
  };
  $pathsContainer.on("click", "button.directory", function(event) {
    var path;
    path = getPathFromButton(event.target);
    return getDirectories(path);
  });
  button.$reset.on("click", function() {
    resetDirectories();
    return $scope.$apply();
  });
  button.$test.on("click", function() {
    return getDirectories();
  });
  $scope.directories = [];
  $scope.current = {
    directory: {
      path: null,
      parent: null
    }
  };
  getPathFromButton = function(button) {
    return $(button).removeData('path').data('path');
  };
  updateDirectories = function(dirs) {
    resetDirectories();
    return dirs.forEach(function(value, index, array) {
      var directory;
      directory = value;
      return $scope.directories[index] = {
        name: directory.name,
        path: directory.path
      };
    });
  };
  updateCurrentPath = function(path) {
    if (path) {
      return $scope.current.directory.path = path;
    }
  };
  updateCurrentParent = function(parent) {
    if (parent) {
      return $scope.current.directory.parent = parent;
    }
  };
  resetDirectories = function() {
    $scope.directories = [];
    $scope.current.directory.path = null;
    return $scope.current.directory.parent = null;
  };
  return getDirectories = function(path) {
    var _data;
    _data = {
      "path": path
    };
    return $.ajax({
      url: "/directories",
      type: "POST",
      contentType: "application/json",
      dataType: "json",
      data: JSON.stringify(_data),
      success: function(data) {
        updateDirectories(data.dirs);
        updateCurrentPath(path);
        updateCurrentParent(data.parent);
        return $scope.$apply();
      }
    });
  };
});

//# sourceMappingURL=main.js.map
