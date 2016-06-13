# Constants
angular.module('myApp')
.constant('RULES', {
  size:
    x: 20
    y: 20
  ships:
    '10':
      size:10
      count: 1
    '5':
      size: 5
      count: 2
    '2':
      size: 2
      count: 3
  state:
    init:  -1
    ship:   0
    frame:  1
    missed: 1
    killed: 2
})