class Application < Sinatra::Base
  helpers do
    def dictionary
      @dictionary ||= MarkyMarkov::Dictionary.new('./dictionary_3')
    end

    def verse(n = 1)
      n = n.to_i
      n = 1 if n.zero?
      dictionary.generate_n_sentences(n)
        .downcase
        .strip
        .gsub(/,$/, '.')
    end
  end

  get '/' do
    HTML.new.page do
      HTML.new.a(href: '/') {
        rand(1..5).times.map { verse(1) }.join '<br>'
      }
    end
  end

  get '/verse' do
    verse params[:n]
  end
end
