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
    @small_font = Gosu::Font.new(self, "Arial", SCREEN_HEIGHT / 50)
    @player = Player.new(self)
    @state = "start"
    @timer = Timer.new
    @obstacles = []
    @spawncount = 20
    @debug = false
  end

  def draw
    @background.draw(0, 0, 0, SCREEN_WIDTH * 1.5 / @background.width, SCREEN_HEIGHT * 1.5 / @background.height)
    draw_text(700, 10, "Your Score: #{@player.score}", @large_font, 0xff000000)
    draw_text(700, 80, "Speed: #{@player.velocity}", @large_font, 0xff000000)
    draw_text(700, 150, "Seconds: #{@timer.seconds}", @large_font, 0xff000000)
    unless @state == "dead"
      @player.player_image.draw(@player.x, @player.y, 1)
      draw_text(@player.x, @player.y, "#{@player.bounds.left}, #{@player.bounds.top}", @small_font, 0xff000000) if @debug
      draw_obstacles
    end
  end

  def update
    unless @state == "dead"
      @player.update
      @timer.update
      spawn_obstacles
      move_obstacles
      clean_obstacles
    end
  end

  def spawn_obstacles
    if @player.velocity != 0

      if @player.score >= @spawncount

        rand(1..3).times do
          @obstacles << Obstacle.new(self)
        end
        @spawncount += 100
      end
    end
  end

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 2, 1, 1, color)
  end

  def clean_obstacles
    unless @obstacles.empty?
      @obstacles.shift if @obstacles[0].y <= 0
    end
  end

  def draw_obstacles
    @obstacles.each do |obstacle|
      obstacle.image.draw(obstacle.x, obstacle.y, 1)
      if @debug
        draw_text(obstacle.x, obstacle.y, "#{obstacle.bounds.left}, #{obstacle.bounds.top}", @small_font, 0xff000000)
        draw_rectangle(obstacle.bounds.left, obstacle.bounds.right, obstacle.bounds.bottom, obstacle.bounds.top)
      end
    end
  end

  def draw_rectangle(x1,x2,y1,y2)
    draw_quad(x1,y1,0xff000000,x1,y2,0xff000000,x2,y2,0xff000000,x2,y1,0xff000000,2)
  end

  def reset_game
    @state = "start"
    @player = Player.new(self)
    @timer = Timer.new
    @spawncount = 100
    @obstacles = []
  end

  def move_obstacles
    unless @obstacles.empty?
      @obstacles.each do |obstacle|
        obstacle.update(@player.velocity)
        @state = "dead" if obstacle.bounds.collision?(@player.bounds)
      end
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

    when Gosu::KbC
      binding.pry

    when Gosu::KbEscape
      close

    when Gosu::KbSpace
      reset_game

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

