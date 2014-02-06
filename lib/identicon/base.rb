class Identicon
  class Base
    def initialize(width: 240, height: width, padding: 0.5, invert: false)
      @width   = width.to_i
      @height  = height.to_i
      @padding = padding.to_f
      @invert  = !!invert
    end
    
    def render(icon)
      raise "Not Implemented!"
    end
  end
end