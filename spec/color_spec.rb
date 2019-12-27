require 'color'


EPSILON = 0.000001
RSpec.describe Color do
  describe 'Color::new' do
    it 'returns a color holding a tuple' do
      color = Color.new(-0.5, 0.4, 1.7)
      expect(color.red).to eq(-0.5)
      expect(color.green).to eq(0.4)
      expect(color.blue).to eq(1.7)
    end
  end

  describe 'Color::hadamard_product' do
    it 'returns a new color with the multiplied values' do
      c1 = Color.new(1, 0.2, 0.4)
      c2 = Color.new(0.9, 1, 0.1)
      c3 = Color::hadamard_product(c1, c2)
      expect(c3.red).to be_within(EPSILON).of 0.9
      expect(c3.green).to be_within(EPSILON).of 0.2
      expect(c3.blue).to be_within(EPSILON).of 0.04
    end
  end

  describe 'Color.(+)' do
    it 'returns a new color with the sum of the values' do
      c1 = Color.new(0.9, 0.6, 0.75)
      c2 = Color.new(0.7, 0.1, 0.25)
      c3 = c1 + c2
      expect(c3.red).to eq 1.6
      expect(c3.green).to eq 0.7
      expect(c3.blue).to eq 1.0
    end
  end

  describe 'Color.(-)' do
    it 'returns a new color with the difference of the values' do
      c1 = Color.new(0.9, 0.6, 0.75)
      c2 = Color.new(0.7, 0.1, 0.25)
      c3 = c1 - c2
      expect(c3.red).to be_within(EPSILON).of 0.2
      expect(c3.green).to be_within(EPSILON).of 0.5
      expect(c3.blue).to be_within(EPSILON).of 0.5
    end
  end

  describe 'Color.(*)' do
    it 'returns a new color with the scaled values' do
      c1 = Color.new(0.2, 0.3, 0.4)
      c2 = c1 * 2
      expect(c2.red).to be_within(EPSILON).of 0.4
      expect(c2.green).to be_within(EPSILON).of 0.6
      expect(c2.blue).to be_within(EPSILON).of 0.8
    end
  end
end