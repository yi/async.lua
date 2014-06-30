

-- source: moonscript_spec.moon
describe "moonscript tests", ->

  async_lua = nil

  setup ->
    async_lua = require "lib.async"

  it "runs", ->
    assert.are.equal true, true

  it "fails", ->
    assert.error(-> assert.are.equal false, true)


