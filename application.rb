class Application < Sinatra::Base
  register Sinatra::AssetPipeline

  set :assets_precompile, %w(application.css)
  set :assets_prefix, %w(assets)
  set :assets_css_compressor, :sass
  set :protection, except: [:frame_options]

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
        rand(1..5).times.map {
          HTML.new.p do
            verse(1).split(',').join('<br>')
          end
        }.join ''
      }
    end
  end

  get '/verse' do
    verse params[:n]
  end
end
