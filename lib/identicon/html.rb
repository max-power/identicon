require 'identicon'
require 'identicon/base'

class Identicon
  def to_html(*args)
    HTML.new(*args).render(self)
  end
    
  class HTML < Base
    def render(icon)
      cell_w  = (100 / (2 * @padding + icon.matrix.column_size)).floor
      cell_h  = (100 / (2 * @padding + icon.matrix.row_size)).floor
      
      content = icon.matrix.map do |cell|
        %Q[<td style="width:#{ cell_w }%;height:#{ cell_h }%;background:#{ icon.color((cell==1) ^ @invert) }"></td>]
      end.to_a.map do |cells|
        %Q[<tr>#{ cells.join }</tr>]
      end.join
      
      %Q[<table#{table_attrs(cell_w, cell_h, icon.color(@invert))}>#{ content }</table>]
    end
    
    private
    
    def table_attrs(cell_w, cell_h, color)
      padd_x = (@padding * (@width.to_f  * cell_w / 100)).floor
      padd_y = (@padding * (@height.to_f * cell_h / 100)).floor
      
      %Q[ cellspacing="0" cellpadding="0" border="0"] +
      %Q[ width="#{ @width }" height="#{ @height }"]  +
      %Q[ style="padding:#{ padd_y }px #{ padd_x }px;background:#{ color }"]
    end
  end
end
