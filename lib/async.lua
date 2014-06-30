local async = { }
async.__index = async
async.eachSeries = function(arr, iterator, callback)
  callback = callback or function() end
  if not (#arr > 0) then
    return callback()
  end
  local completed = 1
  local iterate
  iterate = function()
    iterator(arr[completed], function(err)
      if err then
        callback(err)
        callback = function() end
      else
        completed = completed + 1
        if completed >= #arr then
          callback()
        else
          iterate()
        end
      end
    end)
  end
  iterate()
end
return async
