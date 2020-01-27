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
      if m1.row_at(i) != m2.row_at(i)
        return false
      end
    end

    true
  end
end