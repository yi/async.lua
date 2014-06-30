

-- source: moonscript_spec.moon
describe "moonscript tests", ->

  async_lua = nil

  FIXTURE01 = nil

  setup ->
    async_lua = require "lib.async"
    FIXTURE01 = {"first", "second", "third", "fourth", "fifth"}
    return

  it "async.eachSeries", ->
    async!

    processor = (item, next)->
      print "[processor] item:#{item}"
      next!
      return

    async_lua.eachSeries FIXTURE01, processor, (err)->
      assert.are.equal err, nil
      done!
      return


  it "async.eachSeries should stop chain when error happen", ->
    async!

    processor = (item, next)->
      unless item == "third"
        print "[processor] item:#{item}"
        next!
      else
        print "[processor] item:#{item}, report error"
        next("should not go any further!")
      return

    async_lua.eachSeries FIXTURE01, processor, (err)->
      print "[async_eachseries_spec::test 02] err:#{err}"

      assert.are.equal err, "should not go any further!"
      done!
      return


  it "async.mapSeries", ->
    async!

    processor = (item, next)->
      print "[processor] item:#{item}"
      next nil, item
      return

    async_lua.mapSeries FIXTURE01, processor, (err, results)->
      assert.are.equal err, nil
      assert.are.same FIXTURE01, results
      done!
      return




