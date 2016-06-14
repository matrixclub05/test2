"use strict"

# jasmine specs for services go here

describe "service", ->
  beforeEach module 'myApp'
  beforeEach module "myApp.services"
  describe "GameBoardService", ->
    it "should be defined", inject((GameBoardService) ->
      expect(GameBoardService).toBeDefined()
    )