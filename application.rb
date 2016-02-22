class Application < Sinatra::Base
  register Sinatra::AssetPipeline

  set :assets_precompile, %w(application.css application.js *.ico *png *.svg *.woff *.woff2)
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
      verse = dictionary.generate_n_sentences(n)
        .downcase
        .strip
        .gsub(/,$/, '.')

      RubyPants.new(verse).to_html
    end
  end

  %w(/ /play).map { |route| get route do
    HTML.new.instance_eval do
      page do
        a(href: '/') do
          rand(1..5).times.map do
            p do
              verse(1).split(',').join('<br>')
            end
          end.join ''
        end
      end
    end
  end }

  get '/verse' do
    verse params[:n]
  end
end
