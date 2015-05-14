class Player
  attr_accessor :x, :y, :velocity, :move_left, :move_right, :move_up, :move_down
  attr_reader :player_image, :bounds, :score

  def initialize(window)
    @x = 512
    @y = 150
    @velocity = 2
    @window = window
    @player_image = Gosu::Image.new(@window, "ski-center.png")
    @score = 0
    @move_left = false
    @move_right = false
    @bounds = Boundingbox.new(@x, @y, 20, 32)
  end

  def update

    if move_left
      unless @x <= 0
        @x -= 5
        @player_image = Gosu::Image.new(@window, "ski-left.png")
        @bounds.left -= 5
        @bounds.right -= 5
      end
    end

    if move_right
      unless @x >= (1024 - @player_image.width)
        @x += 5
        @player_image = Gosu::Image.new(@window, "ski-right.png")
        @bounds.left += 5
        @bounds.right += 5
      end
    end

    if move_down
      @player_image = Gosu::Image.new(@window, "ski-center.png")
      @velocity += 1 unless velocity >= 20
    end

    if move_up
      @velocity -= 1 unless @velocity == 0
      @velocity = 0 if @velocity < 0
    end

    @score += @velocity
  end
end
