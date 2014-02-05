require "identicon/version"
require "digest/sha1"
require "matrix"

class Identicon
  def initialize(data='', cols: 5, rows: 5)
    @data = data.to_s
    @rows = rows.to_i
    @cols = cols.to_i
    @half = (cols.to_f / 2).ceil
  end
  
  def digest
    @digest ||= Digest::SHA1.hexdigest(@data)
  end
  
  def binary
    digest.to_i(16).to_s(2).split('').map(&:to_i)
  end
  
  def matrix
    Matrix.columns prepare
  end
  
  def color
    "#" + digest[0,6]
  end
  
  private
  
  def prepare
    binary.reverse.each_slice(@rows).take(@half).tap do |a|
      @half.upto(@cols-1) { |i| a[i] = a[@cols-i-1] }
    end
  end
end