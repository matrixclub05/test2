"use strict"

# Services

GameBoardService = (RULES)->

  Ships =
    user:
      refs: {}
    enemy:
      refs: {}

  isEmptyCell = (x, y, field)->
    d = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]];
    if x > 0 and x < 20 and y > 0 and y < 20 and field[x][y] == RULES.state.init
      i = 0
      while i < 8
        dx = x + d[i][0]
        dy = y + d[i][1]
        if dx > 0 and dx < 20 and dy > 0 and dy < 20 and field[dx][dy] > RULES.state.init
          return true
        i++
      return false
    else
      return true

  getRandomInt = (n) ->
    Math.floor(Math.random() * n)

  fieldInit = ()->
    field = []
    x = 0
    while x < 20
      row = []
      y = 0
      while y < 20
        row[y] = RULES.state.init
        y++
      field[x] = row
      x++
    return field

  setShip = (id, field, N, ships)->
    B = false
    while not B
      x = getRandomInt(RULES.size.x)
      y = getRandomInt(RULES.size.y)
      kx = getRandomInt(2)
      if kx == 0
        ky = 1
      else
        ky = 0
      i = 0
      B = true
      while i < N
        xx = x + kx * i
        yy = y + ky * i
        if isEmptyCell(xx, yy, field)
          B = false
          break
        i++
      if(B)
        i = 0
        ships[id] =
          coords: []

        while i < N
          xx = x + kx * i
          yy = y + ky * i
          field[xx][yy] = 0
          ships.refs["#{xx}_#{yy}"] = id
          coords =
            x: xx
            y: yy
          ships[id].coords.push(coords)
          i++

  getBoard = (isEnemy)->
    field = fieldInit()
    ships = RULES.ships

    for type of ships
      i = 0
      ship = ships[type]
      while i < ship.count
        shipId = type + '_' + i
        if isEnemy
          item =  Ships.enemy
        else
          item =  Ships.user
        setShip(shipId, field, ship.size, item)
        i++
    if isEnemy
      createdShips =  Ships.enemy
    else
      createdShips =  Ships.user
    {
      field: field
      ships: createdShips
    }

  {
    isEmptyCell: isEmptyCell
    setShip: setShip
    initField: fieldInit
    getBoard: getBoard
  }

GameBoardService.$inject = ['RULES']
angular.module("myApp.services", []).factory('GameBoardService', GameBoardService)
