require_relative './generic'

class Markov < Generic
  def dictionary
    @dictionary ||= MarkyMarkov::Dictionary.new(path)
  end

  def verse(n = 1)
    super(nil, n)
  end

  def __verse__(_, n = 1)
    dictionary
      .generate_n_sentences(n)
      .downcase
      .strip
      .gsub(/,$/, '.')
  end
end
