$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'identicon/all'
require 'rack'
require 'new_relic/agent/instrumentation/rack'

class App
  Mapping = {
    svg:  [Identicon::SVG,  'image/svg+xml; charset=utf-8'],
    png:  [Identicon::PNG,  'image/png'],
    html: [Identicon::HTML, 'text/html; charset=utf-8'],
    text: [Identicon::Text, 'text/plain; charset=utf-8']
  }
  Mapping.default = Mapping[:svg]
  
  def call(env)
    path = env["PATH_INFO"][1..-1].to_s.rpartition('.')
    type = path.last.downcase.to_sym
    data = Mapping.key?(type) ? path.first : path.join
    opts = extract_options(env["QUERY_STRING"])
    rows = opts.delete(:rows) || 5
    cols = opts.delete(:cols) || 5

    serve Identicon.new(data, rows: rows, cols: cols), opts, *Mapping[type]
  end
  
  # Do the include after the call method is defined:
  include ::NewRelic::Agent::Instrumentation::Rack
  
  private
  
  def serve(icon, options, renderer, content_type)
    content = renderer.new(options).render(icon)
    headers = {
      "Content-Length" => content.bytesize.to_s,
      "Content-Type"   => content_type,
      "ETag"           => "W/#{icon.digest}",
      "Cache-Control"  => "max-age=3153600"
    }
    [200, headers, [content]]
  end
  
  PermittedParameters = %i(width height padding invert rows cols)
  
  def extract_options(query)
    Rack::Utils.parse_nested_query(query).each_with_object({}) do|(k,v),opts|
      opts[k.to_sym] = v if PermittedParameters.include?(k.to_sym)
    end
  end
end
