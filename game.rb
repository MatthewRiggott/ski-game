require 'gosu'


class Game < Gosu::Window

  SCREEN_HEIGHT = 768
  SCREEN_WIDTH = 1024

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background = Gosu::Image.new(self, 'background.png')
    @large_font = Gosu::Font.new(self, "Arial", SCREEN_HEIGHT / 20)
    # @player = Player.new
    @state = "start"

  end

  def draw
    @background.draw(0, 0, 0, SCREEN_WIDTH * 1.5 / @background.width, SCREEN_HEIGHT * 1.5 / @background.height)
  end

  def update

  end

end

game = Game.new.show

