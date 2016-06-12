# Views from app/views get compiled into ./dist/myapp-views.js
angular.module('myApp')
.constant('RULES', {
  size:
    x: 20
    y: 20
  ships:
    ten:
      size:10
      count: 1
    five:
      size: 5
      count: 2
    two:
      size: 2
      count: 3
  state:
    init: -1
    ship: 0
    missed: 1
    killed: 2
})