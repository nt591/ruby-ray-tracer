class Color
  attr_reader :red, :green, :blue
  def initialize(red, green, blue)
    @red, @green, @blue = red, green, blue
  end

  def +(c2)
    Color.new(
      red + c2.red,
      green + c2.green,
      blue + c2.blue
    )
  end

  def -(c2)
    Color.new(
      red - c2.red,
      green - c2.green,
      blue - c2.blue
    )
  end

  def *(scalar)
    Color.new(
      red * scalar,
      green * scalar,
      blue * scalar
    )
  end

  def self.hadamard_product(c1, c2)
    Color.new(
      c1.red * c2.red,
      c1.green * c2.green,
      c1.blue * c2.blue
    )
  end

  def self.red
    self.for('red')
  end

  def self.for(color)
    case color.downcase
    when 'red'
      Color.new(255, 0, 0)
    when 'green'
      Color.new(0, 255, 0)
    when 'blue'
      Color.new(0, 0 ,255)
    else
      raise UnimplementedColorError "#{color} is not a color"
    end
  end
end

class UnimplementedColorError < StandardError; end

class NullColor
end