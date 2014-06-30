
async = {}
async.__index = async

async.count_table = (t)->
  count = 0
  for k, v in pairs(t) do
    print "[async::count_table] k:#{k}"
    count += 1
  return count

--- async.eachSeries
-- 依次调用 iterator 并且每次传入 arr 中的一个值
-- @param arr 可以增量数值枚举的 table
-- @param iterator 处理器，方法签名： iterator(item, next)->
-- @param callback, 回调函数， 方法签名： callback(err)->
async.eachSeries = (arr, iterator, _collector, callback) ->

  if callback == nil and type(_collector) == "function"
    callback = _collector
    _collector = nil

  unless #arr > 0
    callback! if type(callback) == "function"
    return

  completed = 1
  iterate = ->
    iterator arr[completed], (err, result) ->
      if err
        callback err if type(callback) == "function"
      else
        completed += 1
        table.insert _collector, result if type(_collector) == "table"

        if completed > #arr
          callback! if type(callback) == "function"
        else
          iterate()
      return

    return

  iterate()
  return


async.mapSeries = (arr, iterator, callback) ->

  callback = callback or ->

  _collector = {}

  async.eachSeries arr, iterator, _collector, (err)->
    return callback err if err
    return callback nil, _collector

  return

return async


