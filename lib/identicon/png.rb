require 'identicon'
require 'identicon/base'
require 'chunky_png'

class Identicon
  def to_png(*args)
    PNG.new(*args).render(self)
  end
  
  class PNG < Base
    def render(icon)
      paint(icon).to_blob :fast_rgb
    end
    
    private
    
    def paint(icon)
      ChunkyPNG::Image.new(@width, @height, icon.color(@invert)).tap do |png|
        paint_blocks(png, icon.matrix, icon.color(!@invert))
      end
    end
    
    def paint_blocks(png, matrix, color)
      w = (@width.to_f  / (2 * @padding + matrix.column_size)).floor
      h = (@height.to_f / (2 * @padding + matrix.row_size)).floor
      
      matrix.each_with_index do |fill, row, col|
        next if fill==0
        
        x = ((col + @padding) * w).to_i
        y = ((row + @padding) * h).to_i

        (x...x+w).each do |x|
          (y...y+h).each do |y|
            png.compose_pixel(x, y, color)
          end
        end
      end
    end
  end
end