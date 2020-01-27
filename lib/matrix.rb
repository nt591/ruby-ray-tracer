EPSILON = 0.000001

class Matrix
  attr_reader :data
  def initialize
    @data = []
  end

  def insert(row)
    data << row
  end

  def at(row, column)
    data[row][column]
  end

  def row_count
    data.length
  end

  def row_at(x)
    data[x]
  end

  def self.from(*data)
    m = Matrix.new
    data.each do |r|
      m.insert r
    end
    m
  end

  def self.identical?(m1, m2)
    return false if m1.row_count != m2.row_count
    for i in 0...m1.row_count do
      r1 = m1.row_at(i)
      r2 = m2.row_at(i)
      return false if r1.length != r2.length
      for j in 0..r1.length
        if m1.row_at(i) != m2.row_at(i)
          val1 = m1.at(i, j)
          val2 = m2.at(i, j)
          return false if (val1 - val2).abs > EPSILON
        end
      end
    end

    true
  end
end