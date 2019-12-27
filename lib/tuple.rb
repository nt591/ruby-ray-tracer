class Tuple
  class UnsupportedTupleTypeError < StandardError; end
  def self.for(w)
    if w == 1.0
      Point
    elsif w == 0.0
      Vector
    else
      raise UnsupportedTupleTypeError.new "Invalid w value for Tuple"
    end
  end
end

module TuplesMathable
  def ==(a)
    return Tuples::tuples_equal?(self, a)
  end

  def +(b)
    newW = self.w + b.w
    Tuple.for(newW).new(
      self.x + b.x,
      self.y + b.y,
      self.z + b.z
    )
  end

  def -(b)
    newW = self.w - b.w
    Tuple.for(newW).new(
      self.x - b.x,
      self.y - b.y,
      self.z - b.z
    )
  end
end

module Tuples
  def self.point(x, y, z)
    Point.new(x, y ,z)
  end

  def self.vector(x, y, z)
    Vector.new(x, y ,z)
  end

  def self.tuples_equal?(tuple_a, tuple_b)
    return false if tuple_a.type != tuple_b.type
    return false if tuple_a.x != tuple_b.x
    return false if tuple_a.y != tuple_b.y
    return false if tuple_a.z != tuple_b.z
    true
  end
end

class Point
  include TuplesMathable
  attr_reader :x, :y, :z
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def w
    1.0
  end

  def type
    :point
  end
end

class Vector
  include TuplesMathable
  attr_reader :x, :y, :z
  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def w
    0.0
  end

  def type
    :vector
  end

  def -@
    Vector.new(-x, -y, -z)
  end

  def *(v2)
    Vector.new(
      x * v2,
      y * v2,
      z * v2
     )
  end

  def /(v2)
    Vector.new(
      x / v2,
      y / v2,
      z / v2
     )
  end

  def magnitude
    Math.sqrt(
      x ** 2 +
      y ** 2 +
      z ** 2 +
      w ** 2
    )
  end

  def normalize
    # return a vector scaled down from self to a magnitude of 1
    # aka return a unit vector
    Vector.new(
      x / magnitude,
      y / magnitude,
      z / magnitude
    )
  end

  def dot(v2)
    x * v2.x +
    y * v2.y +
    z * v2.z
  end

  def cross(v2)
    # cross product is the vector perpendicular to both vectors
    # defined as new x = cross of y and z
    # new y = cross of x and z
    # new z = cross of x and y
    Vector.new(
      y * v2.z - z * v2.y,
      z * v2.x - x * v2.z,
      x * v2.y - y * v2.x
    )
  end
end

