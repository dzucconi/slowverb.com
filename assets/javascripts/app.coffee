duration = 300

$el = (word) ->
  $("<span>#{word}</span>")
    .css opacity: 0

queue = (words) ->
  $words = words.map $el

  $('body').append $('</p>').append $.map $words, ($word) ->
    [$word, ' ']

  $words.map ($word) ->
    e: $word
    p: opacity: 1
    o: duration: duration

words = (line) ->
  line.split ' '

run = (callback, offset = duration * 10) ->
  $('body').empty()

  $.get('/verse')
    .then (verse) ->
      sequences = _.flatten(verse
        .split ', '
        .map words
        .map queue
      )

      $.Velocity.RunSequence sequences
      setTimeout callback or run, (sequences.length * duration) + offset

    .fail ->
      setTimeout callback or run, offset

$ ->
  run()
  # Refresh once every 30 minutes (suspected memory leak?)
  [key, val] = location.search.replace('?', '').split '='
  int = if key is 'r' then val else 30
  setTimeout (-> location.reload()), int * 60 * 1000
