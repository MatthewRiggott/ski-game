class Player
  attr_accessor :x, :y, :velocity
  attr_reader :player_image, :bounds

  def initialize(window)
    @x = 600
    @y = 300
    @velocity = 0
    @player_image = Gosu::Image.new(window, "filepath")
  end

  def move


  end


end
