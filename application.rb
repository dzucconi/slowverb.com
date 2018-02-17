class Application < Sinatra::Base
  register Sinatra::AssetPipeline

  set :assets_precompile, %w[application.css application.js *.ico *png *.svg *.woff *.woff2]
  set :assets_prefix, %w[assets]
  set :assets_css_compressor, :sass
  set :protection, except: [:frame_options]

  helpers do
    def model
      MODELS[(params[:model] || DEFAULT_MODEL).to_sym]
    end
  end

  get '/play' do
    redirect to('/')
  end

  get '/' do
    HTML.new.instance_eval do
      page do
        a(href: '/') do
          rand(1..5).times.map do
            p do
              model.verse(1).split(',').join('<br>')
            end
          end.join ''
        end
      end
    end
  end

  get '/verse' do
    model.verse params[:n]
  end

  get '/verse.json' do
    content_type :json, 'charset' => 'utf-8'

    model.verse(params[:n])
         .split(', ')
         .to_json
  end
end
