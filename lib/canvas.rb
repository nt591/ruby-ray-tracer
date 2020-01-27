require_relative './color'
require_relative 'canvas_ppm'

class Canvas
  attr_reader :width, :height, :pixels
  def initialize(width, height)
    @width, @height = width, height
    @pixels = Array.new(height) { Array.new(width) { Color.new(0, 0, 0 )} }
  end

  def write_at(x, y, color)
    return false if !in_range?(x, y)
    pixels[y][x] = color
    true
  end

  def pixel_at(x, y)
    return NullColor.new if !in_range?(x, y)
    pixels[y][x]
  end

  def to_PPM
    CanvasPPM.new(self)
  end

  private

  def in_range?(x, y)
    (0...width).cover?(x) && (0...height).cover?(y)
  end
end