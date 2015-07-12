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
  if location.pathname is '/play'
    run()
    # Refresh once every 30 minutes (suspected memory leak?)
    setTimeout (-> location.reload()), 30 * 60 * 1000
  else
    click = _.partial run, $.noop, 0
    click()
    $(document).click click
