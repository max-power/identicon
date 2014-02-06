require 'identicon'
require 'identicon/base'

class Identicon
  def to_svg(*args)
    SVG.new(*args).render(self)
  end
  
  class SVG < Base
    def render(icon)
      svg_tag background(icon.color(@invert)) + fill(icon.matrix, icon.color(!@invert))
    end
    
    private
    
    def background(color)
      rect_tag(0, 0, @width, @height, color)
    end
    
    def fill(matrix, color)
      matrix.each_with_index.reduce("") do |output, (fill, row, col)|
        output << rect_tag(*coordinates(matrix, row, col), color) if fill==1
        output
      end
    end
    
    def coordinates(matrix, row, col)
      w = (@width.to_f  / (2 * @padding + matrix.column_size)).floor
      h = (@height.to_f / (2 * @padding + matrix.row_size)).floor
      x = w * (col + @padding)
      y = h * (row + @padding)
      [x, y, w, h].map(&:to_i)
    end
    
    def svg_tag(output)
      %Q[<svg width="#{@width}" height="#{@height}" xmlns="http://www.w3.org/2000/svg">#{output}</svg>]
    end
    
    def rect_tag(x, y, w, h, color)
      %Q[<rect x="#{x}" y="#{y}" width="#{w}" height="#{h}" style="fill:#{color}" />]
    end
  end
end