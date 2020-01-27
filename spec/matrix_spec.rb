require 'matrix'

RSpec.describe Matrix do
  describe "construction and inspection" do
    context "the following 4x4" do
      it "accesses the correct values" do
        m = Matrix.from(
          [1, 2, 3, 4],
          [5.5, 6.5, 7.5, 8.5],
          [9, 10, 11, 12],
          [13.5, 14.5, 15.5, 16.5]
        )

        expect(m.at(0, 0)).to eq 1
        expect(m.at(0, 3)).to eq 4
        expect(m.at(1, 0)).to eq 5.5
        expect(m.at(1, 2)).to eq 7.5
        expect(m.at(2, 2)).to eq 11
        expect(m.at(3,0)).to eq 13.5
        expect(m.at(3, 2)).to eq 15.5
      end
    end

    context "the following 2x2" do
      it "accesses the correct values" do
        m = Matrix.from(
          [-3, 5],
          [1, -2],

        )

        expect(m.at(0, 0)).to eq -3
        expect(m.at(0, 1)).to eq 5
        expect(m.at(1, 0)).to eq 1
        expect(m.at(1, 1)).to eq -2
      end
    end

    context "the following 3x3" do
      it "accesses the correct values" do
        m = Matrix.from(
          [-3, 5, 0],
          [1, -2, -7],
          [0, 1, 1]
        )

        expect(m.at(0, 0)).to eq -3
        expect(m.at(0, 1)).to eq 5
        expect(m.at(1, 0)).to eq 1
        expect(m.at(1, 1)).to eq -2
      end
    end
  end

  describe 'matrix equality' do
    context 'with identical structures' do
      it 'returns true' do
        m1 = Matrix.from(
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2]
        )

        m2 = Matrix.from(
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2]
        )

        expect(Matrix.identical?(m1, m2)).to be true
      end
    end

    context 'with different structures' do
      it 'returns true' do
        m1 = Matrix.from(
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2]
        )

        m2 = Matrix.from(
          [2, 3, 4, 5],
          [6, 7, 8, 9],
          [8, 7, 6, 5],
          [4, 3, 2, 1]
        )

        expect(Matrix.identical?(m1, m2)).to be false
      end
    end
  end
end