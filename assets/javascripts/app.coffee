config =
  factor: 75
  pause: 4000

$el = (word) ->
  $("<span>#{word}</span>")
    .css opacity: 0

duration = (token) =>
  token.length * config.factor

queue = (words) ->
  $words = words.map $el

  $('body').append $('</p>').append $.map $words, ($word) ->
    [$word, ' ']

  $words.map ($word) ->
    e: $word
    p: opacity: 1
    o: duration: duration($word.text())

words = (line) ->
  line.split ' '

sum = (xs) ->
  xs.reduce (memo, x) ->
    memo += x
  , 0

run = (callback) ->
  $('body').empty()

  $.get('/verse.json' + window.location.search)
    .then (verses) ->
      lines = verses.map words
      tokens = _.flatten(lines)
      sequences = _.flatten(lines.map queue)
      total = sum(tokens.map duration)

      $.Velocity.RunSequence sequences

      setTimeout (callback or run), (total + config.pause)

    .fail ->
      setTimeout (callback or run), 1000

$ ->
  run()
  # Refresh once every 30 minutes (suspected memory leak?)
  [key, val] = location.search.replace('?', '').split '='
  int = if key is 'r' then val else 30
  setTimeout (-> location.reload()), int * 60 * 1000
