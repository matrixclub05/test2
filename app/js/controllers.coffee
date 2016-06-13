"use strict"

# Controllers
controllers = angular.module("myApp.controllers", [])
controllers.controller("MyCtrl1", [
  "$scope"
  "GameBoardService"
  "RULES"
  ($scope, GameBoardService, RULES) ->
    f1 = GameBoardService.getBoard()
    f2 = GameBoardService.getBoard(true)
    $scope.size = RULES.size
    $scope.state = RULES.state
    $scope.field1 = f1.field
    $scope.userShips = f1.ships

    $scope.field2 = f2.field
    $scope.enemyShips = f2.ships



    $scope.updateField = (e)->
      e.preventDefault()
      f = GameBoardService.getBoard()
      $scope.field1 = f.field
      $scope.userShips = f.ships

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
