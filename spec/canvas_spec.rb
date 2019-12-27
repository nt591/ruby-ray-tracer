require 'canvas'
require 'canvas_ppm'
RSpec.describe Canvas do
  describe 'Canvas::new' do
    it 'returns a canvas with a width and height' do
      canvas = Canvas.new(10, 20)

      expect(canvas.width).to eq 10
      expect(canvas.height).to eq 20
    end

    it 'sets every pixel to a new color of (0, 0, 0)' do
      canvas = Canvas.new(10, 20)

      expect(canvas.pixels.length).to eq canvas.height

      canvas.pixels.each do |row|
        expect(row.length).to eq canvas.width
        row.each do |pixel|
          expect(pixel).to be_a(Color)
          expect(pixel.red).to eq 0
          expect(pixel.green).to eq 0
          expect(pixel.blue).to eq 0
        end
      end
    end
  end

  describe 'Canvas#write_at' do
    it 'updates a canvas with a pixel in a slot if a valid location' do
      canvas = Canvas.new(10, 20)
      red = Color.new(1, 0, 0)
      canvas.write_at(2, 3, red)
      expect(canvas.pixel_at(2, 3)).to be red
    end

    it 'returns false if outside the bounds' do
      canvas = Canvas.new(10, 20)
      red = Color.new(1, 0, 0)
      expect(canvas.write_at(100, 10, red)).to eq false
      # range should exclude end
      expect(canvas.write_at(10, 9, red)).to eq false
      expect(canvas.write_at(9, 20, red)).to eq false
      expect(canvas.write_at(9, 9, red)).to eq true
    end
  end

  describe 'Canvas#to_PPM' do
    it 'returns a CanvasPPM' do
      canvas = Canvas.new(10, 20)
      expect(canvas.to_PPM).to be_a(CanvasPPM)
    end
  end
end