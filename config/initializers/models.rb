MODELS = {
  slow_verb: Markov.new('./models/dictionaries/slow_verb'),
  colors: Text.new('./models/texts/colors')
}

DEFAULT_MODEL = :slow_verb
