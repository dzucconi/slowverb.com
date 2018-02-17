class Generic
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def __verse__
    raise Exception, 'Not implemented'
  end

  def verse(input, n = 1)
    n = n.to_i.zero? ? 1 : n.to_i
    RubyPants.new(__verse__(input, n)).to_html
  end
end
