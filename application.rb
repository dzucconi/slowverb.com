class HTML
  def method_missing(type, attributes = {})
    tag(type, attributes, (block_given? ? yield.to_s : nil))
  end

  def tag(type, attributes, content)
    attributes.map { |k, v|
      "#{k}='#{v}'"
    }.join(' ').let { |attrs|
      " #{attrs}" unless attrs.empty?
    }.let { |attrs|
      content.nil? ? "<#{type}#{attrs}>" : "<#{type}#{attrs}>#{content}</#{type}>"
    }
  end

  def page
    '<!doctype html>' +
    html {
      head {
        meta(charset: 'utf-8') +
        meta('http-equiv' => 'X-UA-Compatible', content: 'IE=edge,chrome=1') +
        title { 'Slow Verb' } +
        style { 'body { font-size: 22px; }' }
      } +
      body { yield }
    }
  end
end


class Application < Sinatra::Base
  helpers do
    def dictionary
      @dictionary ||= MarkyMarkov::Dictionary.new('./dictionary')
    end
  end

  get '/' do
    HTML.new.page do
      dictionary.generate_n_sentences(rand(1..3)).split('. ').join '<br>'
    end
  end
end
