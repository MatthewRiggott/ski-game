class Player
  attr_accessor :x, :y, :velocity, :move_left, :move_right, :move_up, :move_down
  attr_reader :player_image, :bounds, :score

  def initialize(window)
    @x = 512
    @y = 150
    @velocity = 2
    @player_image = Gosu::Image.new(window, "small_rock.png")
    @score = 0
    @move_left = false
    @move_right = false
  end

  def update

    if move_left
      unless @x <= 0
        @x -= 5
      end
    end

    if move_right
      unless @x >= (1024 - @player_image.width)
        @x += 5
      end
    end

    if move_down
      @velocity += 1
    end

    if move_up
      @velocity -= 1 unless @velocity == 0
      @velocity = 0 if @velocity < 0
    end

    @score += @velocity
  end
end
