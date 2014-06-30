

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

    async_lua.eachSeries arr, processor, (err)->
      assert.are.equal err, nil
      done!



