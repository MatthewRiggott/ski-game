require 'gosu'
require_relative 'Boundingbox'

class Obstacle
  attr_reader :bounds, :image, :x, :y

  def initialize(window)

    obstacles = {                        #image ,   width, height
      large_rock: ["large_rock.png", 48, 48, 8, 8 ], #64,64 - 8, 8
      medium_rock: ["medium_rock.png", 90, 60, 10, 15 ], #128,64 -
      small_rock: ["small_rock.png", 24, 24, 4, 4 ], #32,32
      large_tree: ["large_tree.png", 60, 75, 21, 14 ], #102,102
      small_tree: ["small_tree.png", 37, 90, 9, 10 ] #55,110
    }
    obstacle_data = obstacles.values.sample
    @image = Gosu::Image.new(window, obstacle_data[0])
    @y = 700
    @x = rand(0..(1024 - obstacle_data[1]))
    @bounds = Boundingbox.new(@x + obstacle_data[3], @y + obstacle_data[4], obstacle_data[1], obstacle_data[2])
  end

  def update(velocity)
    @y -= velocity
    @bounds.top -= velocity
    @bounds.bottom -= velocity
  end
end

