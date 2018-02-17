require_relative './generic'

class Text < Generic
  def source
    File.expand_path("../../#{path}.txt", __FILE__)
  end

  def verse(n = 1)
    super(nil, n)
  end

  def __verse__(_, n)
    File.readlines(source)
        .sample(n)
        .map { |line| line.downcase.split(';').sample }
        .flatten
        .map { |x| RubyPants.new(x.strip).to_html }
        .take(n)
        .join(', ')
  end
end
