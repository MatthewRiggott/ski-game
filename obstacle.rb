class Obstacle
  attr_reader :bounds
  OBSTACLES = {
                                    #image ,   width, height
    large_rock: [Gosu::Image.new("large_rock.png", 48, 48 )], #64,64
    medium_rock: [Gosu::Image.new("medium_rock.png", 90, 60 )], #128,64
    small_rock: [Gosu::Image.new("small_rock.png", 24, 24 )], #32,32
    large_tree: [Gosu::Image.new("large_tree.png", 60, 75 )], #102,102
    small_tree: [Gosu::Image.new("small_tree.png", 55, 110 )] #64,64
  }


  def initialize()


  end


  def self.generate


  end

end
