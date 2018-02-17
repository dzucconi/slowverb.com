class HTML
  include Sprockets::Helpers

  def method_missing(type, attributes = {})
    tag(type, attributes, (block_given? ? yield.to_s : nil))
  end

  def tag(type, attributes, content)
    attributes.map do |k, v|
      "#{k}='#{v}'"
    end.join(' ').let do |attrs|
      " #{attrs}" unless attrs.empty?
    end.let do |attrs|
      content.nil? ? "<#{type}#{attrs}>" : "<#{type}#{attrs}>#{content}</#{type}>"
    end
  end

  def page
    '<!doctype html>' +
      html do
        head do
          meta(charset: 'utf-8') +
            meta('http-equiv' => 'X-UA-Compatible', content: 'IE=edge,chrome=1') +
            meta(name: 'viewport', content: 'width=device-width') +
            meta(name: 'apple-mobile-web-app-capable', content: 'yes') +
            meta(name: 'apple-mobile-web-app-status-bar-style', content: 'black') +
            title { 'Slow Verb' } +
            link(rel: 'stylesheet', type: 'text/css', href: stylesheet_path('application')) +
            script(src: javascript_path('application'), type: 'text/javascript') {}
        end +
          body do
            yield + Analytics.new.tag(ENV['TRACKING_ID'])
          end
      end
  end
end
