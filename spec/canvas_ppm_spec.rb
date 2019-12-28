require 'canvas_ppm'
require 'canvas'

RSpec.describe CanvasPPM do
  describe 'CanvasPPM#render' do
    it 'returns a header where the first three lines are metadata' do
      canvas = Canvas.new(5, 3)
      ppm = canvas.to_PPM
      expected = "P3\n5 3\n255"
      expect(ppm.segment(0, 2)).to eq expected
      expect(ppm.segment(0, 0)).to eq "P3"
    end

    it 'clamps the values of colors down to the max value' do
      canvas = Canvas.new(5, 3)
      c1 = Color.new(1.5, 0, 0)
      c2 = Color.new(0, 0.5, 0)
      c3 = Color.new(-0.5, 0, 1)
      canvas.write_at(0, 0, c1)
      canvas.write_at(2, 1, c2)
      canvas.write_at(4, 2, c3)

      ppm = canvas.to_PPM

      expected =
"""255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 255"""
      expect(ppm.segment(3, 5)).to eq expected
    end

    it 'splits the lines to a max of 70 characters' do
      canvas = Canvas.new(10, 2)
      c = Color.new(1, 0.8, 0.6)

      (0..9).each do |i|
        (0..1).each do |j|
          canvas.write_at(i, j, c)
        end
      end

      ppm = canvas.to_PPM

      expected =
"""255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
153 255 204 153 255 204 153 255 204 153 255 204 153"""
      expect(ppm.segment(3, 3)).to eq expected
    end

    it 'ends with a new line' do
      canvas = Canvas.new(5, 3)
      ppm = canvas.to_PPM
      expect(ppm.segment(-1, -1)).to eq "\n"
    end
  end
end