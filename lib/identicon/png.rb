require 'identicon'
require 'identicon/base'
require 'chunky_png'

class Identicon
  def to_png(*args)
    PNG.new(self).render(*args).to_blob
  end
  
  class PNG < Base
    def render(params={})
      invert = params.fetch(:invert, false)
      width  = params.fetch(:width,  240)
      height = params.fetch(:height, width)
      padd   = params.fetch(:padding, 0.5).to_f
      cell_w = (width.to_f  / (2 * padd + @matrix.column_size)).floor
      cell_h = (height.to_f / (2 * padd + @matrix.row_size)).floor

      png = ChunkyPNG::Image.new(width.to_i, height.to_i, color(invert))

      @matrix.each_with_index do |fill, row, col|
        if fill==1
          x0 = ((col + padd) * cell_w).to_i
          x1 = (x0 + cell_w).to_i
          y0 = ((row + padd) * cell_h).to_i
          y1 = (y0 + cell_h).to_i

          (x0...x1).each do |x|
            (y0...y1).each do |y|
              png.compose_pixel(x, y, color(!invert))
            end
          end
        end
      end

      png.to_blob :fast_rgba 
    end
  end
end