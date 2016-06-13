"use strict"

# Controllers
controllers = angular.module("myApp.controllers", [])
controllers.controller("MyCtrl1", [
  "$scope"
  "GameBoardService"
  "RULES"
  ($scope, GameBoardService, RULES) ->
    $scope.gameStarted = false
    $scope.showShips = false
    $scope.stopped = true
    $scope.gameReady = false
    $scope.isSet = false

    clenFields = ()->
      $scope.stopped = true
      $scope.field1 = GameBoardService.initField()
      $scope.userShips = {}

      $scope.field2 = GameBoardService.initField()
      $scope.enemyShips = {}
      $scope.gameReady = true
      $scope.isSet = false
      $scope.showShips = false

    clenFields()




    $scope.setShips = (e)->
      if e
        e.preventDefault()
      $scope.size = RULES.size
      $scope.state = RULES.state

      f1 = GameBoardService.getBoard()
      f2 = GameBoardService.getBoard(true)

      $scope.field1 = f1.field
      $scope.userShips = f1.ships

      $scope.field2 = f2.field
      $scope.enemyShips = f2.ships

      $scope.gameReady = true
      $scope.isSet = true

    $scope.updateField = (e)->
      if e
        e.preventDefault()
      f = GameBoardService.getBoard()
      $scope.field1 = f.field
      $scope.userShips = f.ships

    $scope.startGame = (e)->
      e.preventDefault()
      $scope.gameStarted = true
    $scope.toggleShips = (e)->
      e.preventDefault()
      $scope.showShips = !$scope.showShips

    $scope.stopGame = (e)->
      e.preventDefault()
      $scope.gameStarted = false
      clenFields()

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
