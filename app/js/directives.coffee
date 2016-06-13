"use strict"


battleField = ($compile, RULES) ->
  obj =
    restrict: 'EA'
    scope:
      size: '='
      virtualField: '='
      isEnemy: '='
      ships: '='
      showShips: '='
      gameStarted: '='

    compile: (templateElement)->
      {
        pre: (scope)->
          fieldTemplate = (field, size, val)->
            html = ''
            for x in [0...size.x] by 1
              for y in [0...size.y] by 1
                v = if val == null then field[x][y] else RULES.state.init
                if scope.showShips
                  v = field[x][y]
                else
                  if field[x][y] == RULES.state.frame or field[x][y] == RULES.state.killed
                    v = field[x][y]

                html = html + "<div coords='[#{x},#{y}]' class=\"x#{x}-y#{y}\" val=\"#{v}\"></div>"
            return "<div class=\"field\" ng-click=\"onFieldClick($event)\">#{html}</div>"

          renderTpl = (value)->
            html = fieldTemplate(scope.virtualField, RULES.size, value)
            templateElement.empty()
            templateElement.append($compile(html)(scope))
          userWatcher = ()->
            renderTpl(null)

          enemyWatcher = ()->
            renderTpl(RULES.state.init)

          if scope.isEnemy
            scope.$watchCollection('virtualField', enemyWatcher)
            scope.$watch('showShips', (val)->
              if val
                renderTpl(null)
              else
                renderTpl(RULES.state.init)
            )
          else
            scope.$watchCollection('virtualField', userWatcher)
          return
        post: (scope)->

          wrapCell = (x, y, el, field)->
            d = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]]
            i = 0
            while i < 8
              dx = x + d[i][0]
              dy = y + d[i][1]
              if dx >= 0 and dx < 20 and dy >= 0 and dy < 20 and field[dx][dy] is -1
                field[dx][dy] = RULES.state.frame
                el.querySelectorAll(".x" + dx + "-y" + dy)[0].setAttribute('val', RULES.state.frame)
              i++
            el.querySelectorAll(".x" + x + "-y" + y)[0].setAttribute('val', RULES.state.killed)
            return

          killShip = (x, y, el)->
            shipId = scope.ships.refs["#{x}_#{y}"]
            shipCoords = scope.ships[shipId].coords
            i = 0
            while i < shipCoords.length
              x = shipCoords[i].x
              y = shipCoords[i].y
              scope.virtualField[x][y] = RULES.state.killed
              wrapCell(x, y, el, scope.virtualField)
              i++
            return

          if(scope.isEnemy)
            scope.onFieldClick = (e)->
              if not scope.gameStarted
                return false
              cell = e.target
              attrCoords = cell.getAttribute('coords')
              if attrCoords
                coords = JSON.parse(attrCoords)
                x = coords[0]
                y = coords[1]
                if scope.virtualField[x][y] == RULES.state.ship
                  killShip(x, y, e.currentTarget)
                if scope.virtualField[x][y] == RULES.state.missed or scope.virtualField[x][y] == RULES.state.killed
                  e.preventDefault()
                else
                  scope.virtualField[x][y] = RULES.state.missed
                  e.target.setAttribute('val', RULES.state.missed)

          return

      }
  return obj

battleField.$inject = [
  '$compile'
  'RULES'
]
# Directives
angular.module("myApp.directives", [])
.directive("battleField", battleField)