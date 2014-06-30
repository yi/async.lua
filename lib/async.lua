local async = { }
async.__index = async
async.count_table = function(t)
  local count = 0
  for k, v in pairs(t) do
    print("[async::count_table] k:" .. tostring(k))
    count = count + 1
  end
  return count
end
async.eachSeries = function(arr, iterator, _collector, callback)
  if callback == nil and type(_collector) == "function" then
    callback = _collector
    _collector = nil
  end
  if not (#arr > 0) then
    if type(callback) == "function" then
      callback()
    end
    return 
  end
  local completed = 1
  local iterate
  iterate = function()
    iterator(arr[completed], function(err, result)
      if err then
        if type(callback) == "function" then
          callback(err)
        end
      else
        completed = completed + 1
        if type(_collector) == "table" then
          table.insert(_collector, result)
        end
        if completed > #arr then
          if type(callback) == "function" then
            callback()
          end
        else
          iterate()
        end
      end
    end)
  end
  iterate()
end
async.mapSeries = function(arr, iterator, callback)
  callback = callback or function() end
  local _collector = { }
  async.eachSeries(arr, iterator, _collector, function(err)
    if err then
      return callback(err)
    end
    return callback(nil, _collector)
  end)
end
return async
