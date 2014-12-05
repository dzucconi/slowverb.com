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
        style {
          'body { font-size: 22px; }' +
          'a { color: black; text-decoration: none; }'
        }
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
      HTML.new.a(href: '/') {
        rand(1..5).times.map { dictionary.generate_1_sentence }.join '<br>'
      }
    end
  end

  get '/sentence' do
    dictionary.generate_1_sentence
  end
end
