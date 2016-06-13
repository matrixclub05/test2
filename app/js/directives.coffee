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
      shoot: '=?'

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


          fieldWatcher = ()->
            if scope.isEnemy
              renderTpl(RULES.state.init)
            else
              renderTpl(null)
            return

          if scope.isEnemy
            scope.$watch('showShips', (val)->
              if val
                renderTpl(null)
              else
                renderTpl(RULES.state.init)
            )
          scope.$watch('virtualField', fieldWatcher, true)
          return
        post: (scope)->

          handleUserShoot = (e, x,y, field)->
            c =
              x: x
              y: y

            if field[x][y] == RULES.state.missed or field[x][y] == RULES.state.killed
              e.preventDefault()
              scope.shoot = null
            else
              scope.$emit('EnemyShoot', c)

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
                handleUserShoot(e, x, y, scope.virtualField)
              return
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