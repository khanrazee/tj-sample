getNewID = ->
  d = (new Date).getTime()
  if window.performance and typeof window.performance.now == 'function'
    d += performance.now()
  # use high-precision timer if available
  uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) ->
    r = (d + Math.random() * 16) % 16 | 0
    d = Math.floor(d / 16)
    (if c == 'x' then r else r & 0x3 | 0x8).toString 16
  )
  uuid

$ ->
  uniqueKey = getNewID()
  $('#search-field').autocomplete
    source: 'searches/suggestions'
    search: (event, ui) ->
      $.ajax(
        url: 'search_histories'
        data:
          search_key: uniqueKey
          term: $('#search-field').val()
        method: 'POST').done ->
      $(this).addClass 'done'
      return
      return
  return
$('#search-field').keyup ->
  if $('#search-field').val() == ''
    uniqueKey = getNewID()
  return