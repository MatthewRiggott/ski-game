require 'pry'

class Boundingbox
  attr_reader :width, :height
  attr_accessor :top, :bottom, :left, :right

  def initialize(left, top, width, height)
    # x y => top left corner of the box
    @left = left
    @top = top
    @width = width
    @height = height
    @right = left + width
    @bottom = top + height
  end

  def collide?(x, y)
    x >= left && x <= right && y <= bottom && y >= top
  end

  def collision?(box)
    corners = [
      [box.left, box.top],
      [box.left, box.bottom],
      [box.right, box.top],
      [box.right, box.bottom]
    ]
    corners.each do |corner|
      if collide?(corner[0], corner[1])
        return true
      end
    end
    false
  end
end
