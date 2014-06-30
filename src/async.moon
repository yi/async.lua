
async = {}
async.__index = async

async.eachSeries = (arr, iterator, callback) ->
  callback = callback or ->

  return callback() unless #arr > 0
  completed = 1
  iterate = ->
    iterator arr[completed], (err) ->
      if err
        callback err
        callback = ->
      else
        completed += 1
        if completed >= #arr
          callback()
        else
          iterate()
      return

    return

  iterate()
  return



return async


