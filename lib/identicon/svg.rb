require 'identicon'
require 'identicon/base'

class Identicon
  def to_svg(*args)
    SVG.new(self).render(*args)
  end
  
  class SVG < Base
    def render(params={})
      invert = params.fetch(:invert, false)
      width  = params.fetch(:width,  240)
      height = params.fetch(:height, width)
      padd   = params.fetch(:padding, 0.5).to_f
      cell_w = (width.to_f  / (2 * padd + @matrix.column_size)).floor
      cell_h = (height.to_f / (2 * padd + @matrix.row_size)).floor
      
      output = rect_tag(0, 0, width, height, color(invert))
      
      @matrix.each_with_index do |fill, row, col|
        if fill==1
          x = (col + padd) * cell_w
          y = (row + padd) * cell_h
          output << rect_tag(x.to_i, y.to_i, cell_w, cell_h, color(!invert))
        end
      end
      
      svg_tag(width, height, output)
    end
    
    private
    
    def svg_tag(w, h, output)
      %Q[<svg width="#{w}" height="#{h}" xmlns="http://www.w3.org/2000/svg">#{output}</svg>]
    end

    def rect_tag(x, y, w, h, color)
      %Q[<rect x="#{x}" y="#{y}" width="#{w}" height="#{h}" style="fill:#{color}" />]
    end
  end
end