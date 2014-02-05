require 'identicon'

class Identicon
  def to_text(*args)
    Text.new(self).render(*args)
  end

  class Text < Base
    def render(params = {})
      invert = params.fetch(:invert, false)
      @matrix.map { |cell| color((cell==1) ^ invert) }.to_a.map(&:join).join("\n")
    end
    
    private
    
    def color(foreground=true)
      foreground ? "\u2B1B" : "\u2B1C"
    end
  end
end