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

  $.get '/verse', (response) ->
    sequences = _.flatten(response
      .split ', '
      .map words
      .map queue
    )

    $.Velocity.RunSequence sequences
    setTimeout callback or run, (sequences.length * duration) + offset

$ ->
  if location.pathname is '/play'
    run()
  else
    click = _.partial run, $.noop, 0
    click()
    $(document).click click
