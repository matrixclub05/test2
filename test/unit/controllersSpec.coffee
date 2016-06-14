"use strict"

# jasmine specs for controllers go here
describe "controllers", ->
  beforeEach module 'myApp'
  beforeEach module("myApp.controllers")
  it "should ....", inject(($controller) ->
    #spec body
    myCtrl1 = $controller("MyCtrl1",
      $scope: {}
    )
    expect(myCtrl1).toBeDefined()
  )
  it "should ....", inject(($controller) ->
    #spec body
    GameBoard = $controller("GameBoard",
      $scope: {}
    )
    expect(GameBoard).toBeDefined()
  )
