"use strict"
angular.module("myApp", [
  "myApp.views"
  "myApp.filters"
  "myApp.services"
  "myApp.directives"
  "myApp.controllers"
  "ngRoute"
]).config [
  "$routeProvider"
  ($routeProvider) ->
    $routeProvider.when "/view1",
      templateUrl: "/partial1.html"
      controller: "MyCtrl1"

    $routeProvider.when "/view2",
      templateUrl: "/partial2.html"
      controller: "GameBoard"

    $routeProvider.otherwise redirectTo: "/view1"
]
