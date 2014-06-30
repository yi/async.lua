# async.lua

This is a port of [caolan's Async.js](https://github.com/caolan/async) lib into lua

By now, only `async.eachSeries` and `async.mapSeries` has been implementated

## Usage

``` lua
local async = require("lib.async")
local FIXTURE01 = { "first", "second", "third", "fourth", "fifth" }
local processor = function(item, next)
  print("[processor] item:" .. tostring(item))
  next()
end
async.eachSeries(FIXTURE01, processor, function(err)
  assert((err == nil))
  end
)
```

for more, please refer to [eachSeries](https://github.com/caolan/async#eachseriesarr-iterator-callback) and [mapSeries](https://github.com/caolan/async#mapSeries)

## Test

Test specs are written in [moonscript](http://www.moonscript.com/) on [busted](https://github.com/Olivine-Labs/busted)

To run tests, do:

```sh
busted spec/
```



