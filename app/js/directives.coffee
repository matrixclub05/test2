"use strict"

fieldTemplate = (field, size, val)->
  html = ''
  for x in [0...size.x] by 1
    for y in [0...size.y] by 1
      v = if val == -1 then -1 else field[x][y]

      html = html + "<div coords='[#{x},#{y}]' value=\"#{v}\"></div>"
  return "<div class=\"field\" ng-click=\"onFieldClick($event)\">#{html}</div>"

battleField = ($compile) ->
  obj =
    restrict: 'EA'
    scope:
      size: '='
      virtualField: '='
      isEnemy: '='

    compile: (templateElement)->

      fieldTemplate = (field, size, val)->
        html = ''
        for x in [0...size.x] by 1
          for y in [0...size.y] by 1
            vv = if val == null then field[x][y] else -1

            html = html + "<div coords='[#{x},#{y}]' value=\"#{vv}\"></div>"
        return "<div class=\"field\" ng-click=\"onFieldClick($event)\">#{html}</div>"

      {
        pre: (scope, element, attrs)->
          ###v = if scope.isEnemy then -1 else null
          html = fieldTemplate(scope.virtualField, scope.size, v)
          templateElement.empty()
          templateElement.append($compile(html)(scope))###

          userWatcher = ()->
            v = if scope.isEnemy then -1 else null
            html = fieldTemplate(scope.virtualField, scope.size, v)
            templateElement.empty()
            templateElement.append($compile(html)(scope))
          enemyWatcher = ()->
            v = if scope.isEnemy then -1 else null
            html = fieldTemplate(scope.virtualField, scope.size, v)
            templateElement.empty()
            templateElement.append($compile(html)(scope))
          if scope.isEnemy
            scope.$watchCollection('virtualField', enemyWatcher)
          else
            scope.$watchCollection('virtualField', userWatcher)
          return
        post: (scope, element, attrs)->
          if(scope.isEnemy)
            scope.onFieldClick = (e)->
              cell = e.target
              attrCoords = cell.getAttribute('coords')
              if attrCoords
                coords = JSON.parse(attrCoords)
                x = coords[0]
                y = coords[1]
                if scope.virtualField[x][y] == 0
                  scope.virtualField[x][y] = 2
                  e.target.setAttribute('value', 2)
                if scope.virtualField[x][y] == 1 or scope.virtualField[x][y] == 2
                  e.preventDefault()
                else
                  scope.virtualField[x][y] = 1
                  e.target.setAttribute('value', 1)

          else
            scope.onFieldClick = (e) ->
              cell = e.target
              coords = JSON.parse(cell.getAttribute('coords'))
              x = coords[0]
              y = coords[1]
              if scope.virtualField[x][y] > 0
                scope.virtualField[x][y] = 1
                e.target.setAttribute('value', 1)
              else
                scope.virtualField[x][y] = 0
                e.target.setAttribute('value', 0)
          return

      }
  return obj

enemyField = ($compile) ->
  obj =
    restrict: 'EA'
    scope:
      size: '='
      virtualField: '='

    compile: (templateElement, templateAttrs)->

      {
        pre: (scope, element, attrs)->
          html = fieldTemplate(scope.virtualField, scope.size, -1)
          templateElement.append($compile(html)(scope))
          return
        post: (scope, element, attrs)->
          scope.onFieldClick = (e) ->
            cell = e.target
            coords = JSON.parse(cell.getAttribute('coords'))
            x = coords[0]
            y = coords[1]
            if scope.virtualField[x][y] == 0
              scope.virtualField[x][y] = 2
              e.target.setAttribute('value', 2)
            if scope.virtualField[x][y] == 1 or scope.virtualField[x][y] == 2
              e.preventDefault()
            else
              scope.virtualField[x][y] = 1
              e.target.setAttribute('value', 1)
          return

      }
  return obj

# Directives
angular.module("myApp.directives", [])
.directive("battleField", battleField)
.directive("enemyField", enemyField)




