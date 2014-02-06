require 'identicon'

class Identicon
  def to_text(*args)
    Text.new(*args).render(self)
  end

  class Text < Base
    def render(icon)
      icon.matrix.map { |fill| char(fill==1) }.to_a.map(&:join).join("\n")
    end
    
    private
    
    def char(fill)
      (fill ^ @invert) ? "\u2B1B" : "\u2B1C"
    end
  end
end