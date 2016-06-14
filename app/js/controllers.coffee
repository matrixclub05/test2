"use strict"

# Controllers

angular.module("myApp.controllers", [])
.controller("GameBoard", [
  "$scope"
  "GameBoardService"
  "RULES"
  ($scope, GameBoardService, RULES) ->
    $scope.gameStarted = false
    $scope.showShips = false
    $scope.stopped = true
    $scope.gameReady = false
    $scope.isSet = false
    $scope.enemyShoot = null
    $scope.shipCountEnemy = GameBoardService.getShipsCount()
    $scope.shipCountUser = GameBoardService.getShipsCount()

    $scope.enemyWin = false
    $scope.userWin = false

    cleanFields = ()->
      $scope.stopped = true
      $scope.field1 = GameBoardService.initField()
      $scope.userShips = {}

      $scope.field2 = GameBoardService.initField()
      $scope.enemyShips = {}
      $scope.gameReady = false
      $scope.isSet = false
      $scope.showShips = false

      $scope.userWin = false
      $scope.enemyWin = false

    cleanFields()

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
      $scope.shipCountEnemy = GameBoardService.getShipsCount()
      $scope.shipCountUser = GameBoardService.getShipsCount()
      return

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
      cleanFields()

    shootHandler = (val, coords)->
      c = GameBoardService.getRndCell($scope.field1)
      if GameBoardService.handleUserShoot(coords.x, coords.y, $scope.field2, $scope.enemyShips)
        $scope.shipCountEnemy--
        if $scope.shipCountEnemy == 0
          $scope.userWin = true

      if GameBoardService.handleUserShoot(c.x, c.y, $scope.field1, $scope.userShips)
        $scope.shipCountUser--
        if $scope.shipCountUser == 0
          $scope.enemyWin = true

      return
    $scope.restart = (e)->
      e.preventDefault()
      $scope.stopGame(e)
      $scope.userWin = false
      $scope.enemyWin = false
      $scope.setShips(e)
      $scope.startGame(e)


    $scope.onFieldClick = (e)->
      if not $scope.gameStarted
        return false
      cell = e.target
      attrCoords = cell.getAttribute('coords')
      if attrCoords
        coords = JSON.parse(attrCoords)
        c =
          x:coords[0]
          y:coords[1]
        shootHandler(null, c)
      return

    return
])

.controller("MyCtrl1", [
  "$scope"
  ($scope) ->

])
