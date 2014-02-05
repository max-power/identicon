require 'identicon'
require 'identicon/base'

class Identicon
  def to_html(*args)
    HTML.new(self).render(*args)
  end
    
  class HTML < Base
    def render(params={})
      @invert = params.fetch(:invert, false)
      width   = params.fetch(:width,  240)
      height  = params.fetch(:height, width)
      padd    = params.fetch(:padding, 0.5).to_f
      @cell_w  = (100 / (2 * padd + @matrix.column_size)).floor
      @cell_h  = (100 / (2 * padd + @matrix.row_size)).floor
      
      padd_x = (padd * (width.to_f  * @cell_w / 100)).floor
      padd_y = (padd * (height.to_f * @cell_h / 100)).floor
      
      %Q[<table style="padding:#{ padd_y }px #{ padd_x }px;background:#{ color(@invert) }" width="#{ width }" height="#{ height }" cellspacing="0" cellpadding="0" border="0">#{ rows }</table>]
    end
    
    private
    
    def rows
      @matrix.to_a.map { |row| %Q[<tr>#{ cells(row).join }</tr>] }.join
    end
    
    def cells(row)
      row.map { |cell| %Q[<td style="width:#{ @cell_w }%;height:#{ @cell_h }%;background:#{ color((cell==1) ^ @invert) }"></td>] }
    end
    
  end
end
