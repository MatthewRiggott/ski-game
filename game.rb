require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'obstacle'
require_relative 'timer'

class Game < Gosu::Window

  SCREEN_HEIGHT = 768
  SCREEN_WIDTH = 1024

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background = Gosu::Image.new(self, 'background.png')
    @large_font = Gosu::Font.new(self, "Arial", SCREEN_HEIGHT / 20)
    @player = Player.new(self)
    @state = "start"
    @timer = Timer.new
    @obstacles = []
  end

  def draw
    @background.draw(0, 0, 0, SCREEN_WIDTH * 1.5 / @background.width, SCREEN_HEIGHT * 1.5 / @background.height)
    @player.player_image.draw(@player.x, @player.y, 1)
    draw_obstacles
    draw_text(700, 10, "Your Score: #{@player.score}", @large_font, 0xff000000)
  end

  def update
    @player.update
    @timer.update
    spawn_obstacles
    move_obstacles
  end

  def spawn_obstacles
    if @player.velocity != 0



      (1..3).to_a.sample.times do
        @obstacles << Obstacle.new(self)
      end
    end
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 2, 1, 1, color)
  end

  def draw_obstacles
    @obstacles.each do |obstacle|
      obstacle.image.draw(obstacle.x, obstacle.y, 1)
    end
  end

  def move_obstacles
    @obstacles.each do |obstacle|
      obstacle.update(@player.velocity)
    end
  end

  def button_down(key)
    case key
    when Gosu::KbLeft
      @player.move_left = true

    when Gosu::KbRight
      @player.move_right = true

    when Gosu::KbUp
      @player.move_up = true

    when Gosu::KbDown
      @player.move_down = true

    when Gosu::KbEsc
      close
    end
  end

  def button_up(key)
    if key == Gosu::KbLeft
      @player.move_left = false
    end

    if key == Gosu::KbRight
      @player.move_right = false
    end

    if key == Gosu::KbUp
      @player.move_up = false
    end

    if key == Gosu::KbDown
      @player.move_down = false
    end
  end
end

game = Game.new.show

