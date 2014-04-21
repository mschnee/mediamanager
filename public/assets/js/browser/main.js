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
      path: " ",
      name: null,
      parentPath: null,
      parentName: null
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
    var name, nameStart;
    if (path) {
      nameStart = path.lastIndexOf("/");
      name = path.substr(nameStart + 1, path.length - 1);
      $scope.current.directory.path = path;
      return $scope.current.directory.name = name;
    }
  };
  updateCurrentParent = function(parentPath) {
    var parentName, parentNameStart;
    if (parentPath) {
      parentNameStart = parentPath.lastIndexOf("/");
      parentName = parentPath.substr(parentNameStart + 1, parentPath.length - 1);
      $scope.current.directory.parentPath = parentPath;
      return $scope.current.directory.parentName = parentName;
    }
  };
  resetDirectories = function() {
    $scope.directories = [];
    $scope.current.directory.path = " ";
    $scope.current.directory.name = null;
    $scope.current.directory.parentPath = null;
    return $scope.current.directory.parentName = null;
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
