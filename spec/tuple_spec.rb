require 'tuple'

RSpec.describe Tuple do
  it "returns a Point with a w of 1" do
    a = Tuple.for(1.0).new(4.3, -4.2, 3.1)

    expect(a.x).to eq(4.3)
    expect(a.y).to eq(-4.2)
    expect(a.z).to eq(3.1)
    expect(a.w).to eq(1.0)
    expect(a).to be_a(Point)
    expect(a).to_not be_a(Vector)
  end

  it "returns a Vector with a w of 0" do
    a = Tuple.for(0.0).new(4.3, -4.2, 3.1)

    expect(a.x).to eq(4.3)
    expect(a.y).to eq(-4.2)
    expect(a.z).to eq(3.1)
    expect(a.w).to eq(0.0)
    expect(a).to be_a(Vector)
    expect(a).to_not be_a(Point)
  end

  it 'allows vectors to negate' do
    a = Tuple.for(0).new(4, 5, 6)
    b = -a

    expect(b).to be_a(Vector)
    expect(b.x).to be(-4)
    expect(b.y).to be(-5)
    expect(b.z).to be(-6)
  end

  it 'allows Vectors to multiply by a scalar value' do
    vector = Tuple.for(0).new(1, -2, 4)
    v1 = vector * 3.5

    expect(v1).to be_a(Vector)
    expect(v1.x).to eq(3.5)
    expect(v1.y).to eq(-7)
    expect(v1.z).to eq(14)
  end

  it 'allows Vectors to divide by a scalar value' do
    vector = Tuple.for(0).new(7, -14, 28)
    v1 = vector / 3.5

    expect(v1).to be_a(Vector)
    expect(v1.x).to eq(2.0)
    expect(v1.y).to eq(-4.0)
    expect(v1.z).to eq(8.0)
  end

  describe 'Vector#magnitude' do
    it 'calculates the magnitude of a given vector' do
      #  It’s how far you would travel in a straight line
      # if you were to walk from one end of the vector to the other
      vector = Tuple.for(0).new(1, 2, 3)

      expect(vector.magnitude).to eq Math.sqrt(14)
    end
  end

  describe 'Vector#normalize' do
    it 'returns a vector in the same direction with a magnitude of 1' do
      vector = Tuple.for(0).new(1, 2, 3)
      normalized = vector.normalize

      expect(normalized).to be_a(Vector)
      expect(normalized.magnitude).to eq 1
      expect(normalized.x).to eq(1 / Math.sqrt(14))
      expect(normalized.y).to eq(2 / Math.sqrt(14))
      expect(normalized.z).to eq(3 / Math.sqrt(14))
    end
  end

  describe 'Vector#dot' do
    it 'returns the sum of the products of two vectors' do
      v1 = Vector.new(1, 2, 3)
      v2 = Vector.new(2, 3, 4)

      expect(v1.dot(v2)).to eq 20
    end
  end

  describe 'Vector#cross' do
    it 'returns a new vector perpendicular to both vectors' do
      v1 = Vector.new(1, 2, 3)
      v2 = Vector.new(2, 3, 4)

      expected1 = Vector.new(-1, 2, -1)
      expected2 = Vector.new(1, -2, 1)

      expect(v1.cross(v2) == expected1).to be true
      expect(v2.cross(v1) == expected2).to be true
    end
  end

  describe 'tuples module' do
    it "contains a Point method that returns a point" do
      a = Tuples::point(4, -4, 3)

      expect(a.x).to eq(4)
      expect(a.y).to eq(-4)
      expect(a.z).to eq(3)
      expect(a.w).to eq(1.0)
      expect(a).to be_a(Point)
      expect(a).to_not be_a(Vector)
    end

    it "contains a Vector method that returns a vector" do
      a = Tuples::vector(4, -4, 3)

      expect(a.x).to eq(4)
      expect(a.y).to eq(-4)
      expect(a.z).to eq(3)
      expect(a.w).to eq(0.0)
      expect(a).to be_a(Vector)
      expect(a).to_not be_a(Point)
    end

    describe 'tuples_equal? function' do
      it 'returns true if two tuples are the same type with same values' do
        a = Tuple.for(1).new(1, 2, 3)
        b = Tuples::point(1, 2, 3)

        expect(Tuples::tuples_equal?(a, b)).to be true
        expect(a == b).to be true
      end

      it 'returns false if two tuples are not the same type' do
        a = Tuple.for(1).new(1, 2, 3)
        b = Tuple.for(0).new(1, 2, 3)
        # expect(Tuples::tuples_equal?(a, b)).to be false
        expect(a == b).to be false
      end

      it 'returns false if two tuples are the same type but differing values' do
        a = Tuple.for(0).new(1, 2, 3)
        b = Tuple.for(0).new(1, 2, 300)
        expect(Tuples::tuples_equal?(a, b)).to be false
        expect(a == b).to be false
      end
    end
  end

  describe 'TupleMathable module' do
    describe 'contains a + method' do
      it 'adds two vectors and returns a vector' do
        a = Tuple.for(0).new(1, 1, 1)
        b = Tuple.for(0).new(5, 6, 7)
        c = a + b

        expect(c.x).to be(6)
        expect(c.y).to be(7)
        expect(c.z).to be(8)
        expect(c).to be_a(Vector)
      end

      it 'takes a point and vector and returns a new point' do
        a = Tuple.for(1).new(-10, -10, -10)
        b = Tuple.for(0).new(5, 6, 7)
        c = a + b

        expect(c.x).to be(-5)
        expect(c.y).to be(-4)
        expect(c.z).to be(-3)
        expect(c).to be_a(Point)
      end

      it 'takes a vector and point and returns a new point' do
        a = Tuple.for(0).new(-10, -10, -10)
        b = Tuple.for(1).new(5, 6, 7)
        c = a + b

        expect(c.x).to be(-5)
        expect(c.y).to be(-4)
        expect(c.z).to be(-3)
        expect(c).to be_a(Point)
      end

      it 'takes a point and point and returns an error' do
        a = Tuple.for(1).new(-10, -10, -10)
        b = Tuple.for(1).new(5, 6, 7)
        expect { a + b }.to raise_error(Tuple::UnsupportedTupleTypeError)
      end
    end

    describe 'contains a - method' do
      it 'subtracts two points and returns a vector from p2 to p1' do
        a = Tuple.for(1).new(10, 10, 10)
        b = Tuple.for(1).new(1, 2, 3)

        c = a - b

        expect(c).to be_a(Vector)
        expect(c.x).to be(9)
        expect(c.y).to be(8)
        expect(c.z).to be(7)
      end

      it 'subtracts a vector from a point and returns a point' do
        # going backwards from point
        point = Tuple.for(1).new(10, 10, 10)
        vector = Tuple.for(0).new(4, 5, 6)

        c = point - vector

        expect(c).to be_a(Point)
        expect(c.x).to be(6)
        expect(c.y).to be(5)
        expect(c.z).to be(4)
      end

      it 'subtracts two vectors and returns a vector' do
        v1 = Tuple.for(0).new(10, 10, 10)
        v2 = Tuple.for(0).new(4, 5, 6)

        c = v1 - v2

        expect(c).to be_a(Vector)
        expect(c.x).to be(6)
        expect(c.y).to be(5)
        expect(c.z).to be(4)
      end

      it 'raises an error if subtract a point from a vector' do
        vector = Tuple.for(0).new(10, 10, 10)
        point = Tuple.for(1).new(4, 5, 6)

        expect { vector - point }.to raise_error(Tuple::UnsupportedTupleTypeError)
      end
    end
  end
end