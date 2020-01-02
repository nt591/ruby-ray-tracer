class CanvasPPM
  attr_reader :canvas
  def initialize(canvas)
    @canvas = canvas
  end

  def render
    segment(0, -1)
  end

  def segment(start, finish)
    arr = lines.slice(start..finish)
    # if we're slicing up to the end, don't join the last_line with \n


    lines.slice(start..finish).join("\n")
  end

  private

  def lines
    [metadata, pixel_data, last_line].flatten
  end

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

  def last_line
    "\n"
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
      string_arr = []
      count = 0
      pixels = row.map { |pixel| format_pixel pixel}.flatten

      # collect pixels by pulling into temp
      # flush when count gets too high

      pixels.each do |color|
        # flush temp if we need it
        charsize = color.to_s.length + 1 # implicit space
        if charsize + count > 70
          count = 0
          string_arr << temp.join(" ")
          temp = []
        end
        temp << color
        count += charsize
      end

      # handle leftover temp
      string_arr << temp.join(" ")

      string_arr
    end

    private

    def format_pixel(pixel)
      [
        format_color(pixel.red),
        format_color(pixel.green),
        format_color(pixel.blue),
      ]
    end

    def format_color(color)
      return max_color_val if color >= 1
      return 0 if color <= 0
      (color * max_color_val).round
    end
  end
end