class Identicon
  class Base
    def initialize(icon)
      @icon, @matrix  = icon, icon.matrix
    end
    
    def color(foreground=true)
      foreground ? @icon.color : '#e0e0e0'
    end
    
    def render(params={})
      raise "Not Implemented!"
    end
  end
end