"use strict"

# https://github.com/angular/protractor/blob/master/docs/getting-started.md
describe "my app", ->
  browser.get "index.html"
  it "should automatically redirect to /view1 when location hash/fragment is empty", ->
    expect(browser.getLocationAbsUrl()).toMatch "/view1"
    return

  describe "view1", ->
    beforeEach ->
      browser.get "index.html#/view1"
      return

    it "should render view1 when user navigates to /view1", ->
      expect(element.all(By.css("[ng-view] p")).first().getText()).toMatch /partial for view 1/
      return

    return

  describe "view2", ->
    beforeEach ->
      browser.get "index.html#/view2"
      return

    it "should render view2 when user navigates to /view2", ->
      expect(element.all(By.css("[ng-view] p")).first().getText()).toMatch /partial for view 2/
      return

    return

  return
