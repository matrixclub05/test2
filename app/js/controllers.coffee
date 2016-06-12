"use strict"

# Controllers
controllers = angular.module("myApp.controllers", [])
controllers.controller("MyCtrl1", [
  "$scope"
  "GameBoardService"
  "RULES"
  ($scope, GameBoardService, RULES) ->

    $scope.size = RULES.size
    $scope.state = RULES.state
    $scope.field1 = GameBoardService.getField()
    $scope.field2 = GameBoardService.getEnemyField()

    $scope.updateField = (e)->
      e.preventDefault()
      $scope.field1 = GameBoardService.field.getField()

    return
])

controllers.controller "MyCtrl2", [
  "$scope"
  ($scope) ->
    # controller 2 code goes here
    $scope.name = "MyCtrl2"
    $scope.doIt = ->
      alert "Done! #{$scope.name}"
]
