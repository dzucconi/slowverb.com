$el = (word) ->
  $("<span>#{word}</span>")
    .css(opacity: 0)

queue = (words) ->
  $words = words.map $el
  $('body').append $('</p>').append $.map $words, ($word) -> [$word, ' ']
  $words.map ($word) -> e: $word, p: { opacity: 1 }, o: { duration: 250 }

verse = ->
  $('body').empty()
  $.get '/verse', (response) ->
    sequences = response
      .split ', '
      .map (line) -> line.split ' '
      .map queue
    $.Velocity.RunSequence _.flatten sequences

$ ->
  verse()
  $(document).click verse
