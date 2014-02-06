require "identicon/version"
require "digest/sha1"
require "matrix"

class Identicon
  def initialize(data='', cols: 5, rows: cols)
    @data = data.to_s
    @rows = rows.to_i
    @cols = cols.to_i
    @half = (@cols + 1) / 2
  end
  
  def digest
    @digest ||= Digest::SHA1.hexdigest(@data)
  end
  
  def binary
    digest.to_i(16).to_s(2).split('').map(&:to_i)
  end

  def foreground_color
    "#" + digest[0,6]
  end
  
  def background_color
    "#e0e0e0"
  end
  
  def color(foreground=true)
    foreground ? foreground_color : background_color
  end
  
  def matrix
    Matrix.columns prepare
  end
  
  private
  
  def prepare
    binary.reverse.each_slice(@rows).take(@half).tap do |matrix|
      (@half...@cols).each do |row|
        matrix[row] = matrix[@cols-1-row]
      end
    end
  end
end