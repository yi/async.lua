

-- source: moonscript_spec.moon
describe "moonscript tests", ->

  async_lua = nil

  setup ->
    async_lua = require "lib.async"

  it "async.eachSeries", ->
    async!

    arr = {"first", "second", "third", "fourth", "fifth"}

    processor = (item, next)->
      print "[processor] item:#{item}"
      next!
      return

    async_lua.eachSeries arr, processor, (err)->
      assert.are.equal err, nil
      done!
      return


  it "async.eachSeries should stop chain when error happen", ->
    async!

    arr = {"first", "second", "third", "fourth", "fifth"}

    processor = (item, next)->
      unless item == "third"
        print "[processor] item:#{item}"
        next!
      else
        print "[processor] item:#{item}, report error"
        next("should not go any further!")
      return

    async_lua.eachSeries arr, processor, (err)->
      assert.are.equal err, "should not go any further!"
      done!
      return




