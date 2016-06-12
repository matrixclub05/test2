"use strict"

# Services

# Demonstrate how to register services
# In this case it is a simple value service.


GameBoardService = (RULES)->
  boardSize = RULES.size

  firstField = []
  ships = {}
  isEmptyCell = (x, y, field)->
    d = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]];
    if x > 0 and x < 20 and y > 0 and y < 20 and field[x][y] == -1
      i = 0
      while i < 8
        dx = x + d[i][0]
        dy = y + d[i][1]
        if dx > 0 and dx < 20 and dy > 0 and dy < 20 and field[dx][dy] > -1
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
        row[y] = -1
        y++
      field[x] = row
      x++
    return field

  setShip = (field, N)->
    B = false
    while not B
      x = getRandomInt(20)
      y = getRandomInt(20)
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
        ships[N] = []
        while i < N
          xx = x + kx * i
          yy = y + ky * i
          field[xx][yy] = 0
          i++
  getEnemyField = ()->
    field = fieldInit()
    ships = RULES.ships

    for ship of ships
      i = 0
      s = ships[ship]
      while i < s.count
        setShip(field, s.size)
        i++

  getField = ()->
    field = fieldInit()
    ships = RULES.ships

    for ship of ships
      i = 0
      s = ships[ship]
      while i < s.count
        setShip(field, s.size)
        i++

    return field
  {
    isEmptyCell: isEmptyCell
    setShip: setShip
    initField: fieldInit
    getField: getField
  }

GameBoardService.$inject = ['RULES']
angular.module("myApp.services", []).factory('GameBoardService', GameBoardService)
