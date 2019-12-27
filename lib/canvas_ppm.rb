class CanvasPPM
  attr_reader :canvas
  def initialize(canvas)
    @canvas = canvas
  end

  def to_s
    segment(0, -1)
  end

  def lines
    [metadata, pixel_data].flatten
  end

  def segment(start, finish)
    lines.slice(start..finish).join("\n")
  end

  private

  def metadata
    [
      magic_number,
      "#{canvas.width} #{canvas.height}",
      max_color_val
    ]
  end

  def pixel_data
    collection = []
    canvas.pixels.each do |pixel_row|
      collection << RowFormatter.new(pixel_row, max_color_val).format
    end
    collection
  end

  def max_color_val
    255
  end

  def magic_number
    "P3"
  end

  class RowFormatter
    attr_reader :row, :max_color_val
    def initialize(row, max_color_val)
      @row = row
      @max_color_val = max_color_val
    end

    def format
      temp = []
      row.each do |pixel|
        temp << format_pixel(pixel)
      end
      temp.join(" ")
    end

    private

    def format_pixel(pixel)
      [
        format_color(pixel.red),
        format_color(pixel.green),
        format_color(pixel.blue),
      ].join(" ")
    end

    def format_color(color)
      return max_color_val if color >= 1
      return 0 if color <= 0
      (color * max_color_val).round
    end
  end
end