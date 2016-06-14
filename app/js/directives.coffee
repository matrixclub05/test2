"use strict"

battleField = () ->
  obj =
    restrict: 'EA'
    templateUrl: '/field.html'
    scope:
      isEnemy: '='
      virtualField: '='
      showShips: '='
      gameStarted: '='
      shipCounter: '='
    link: (scope)->
      scope.size = 100/scope.virtualField.length
      scope.size += '%'
      return
  return obj

# Directives
angular.module("myApp.directives", [])
.directive("battleField", battleField)
