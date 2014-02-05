$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'identicon/all'
require 'rack'

class App
  CONTENT_TYPES = {
    svg: 'image/svg+xml; charset=utf-8',
    png: 'image/png',
    html: 'text/html; charset=utf-8',
    text: 'text/plain; charset=utf-8'
  }
  
  def initialize
    @headers = {}
  end

  def call(env)
    opts = extract_options(env["QUERY_STRING"])
    path = env["PATH_INFO"][1..-1].to_s.rpartition('.')
    type = renderer(path.last)
    icon = Identicon.new(path.send(type ? :first : :join), rows: opts[:rows] || 5, cols: opts[:cols] || 5)
    
    serve Identicon.const_get(type || :SVG).new(icon).render(opts), (type || :SVG).to_s.downcase
  end

  private
  
  def renderer(ext)
    Identicon.constants.detect { |s| s == ext.capitalize.to_sym || s == ext.upcase.to_sym }
  end

  def extract_options(query)
    Rack::Utils.parse_nested_query(query).each_with_object({}) {|(k,v),opts| opts[k.to_sym] = v }
  end
  
  def serve(output, type)
    @headers['Content-Length'] = output.bytesize.to_s
    @headers['Content-Type']   = CONTENT_TYPES[type.to_sym]
    [200, @headers, [output]]
  end
end
