class Boundingbox
  attr_reader :left, :right, :top, :bottom, :width, :height

  def initialize(left, top, width, height)
    # x y => top left corner of the box
    @left = left
    @top = top
    @width = width
    @height = height
    @right = left + width
    @bottom = top + height
  end

  def collide?(box)
    self.right > box.left && self.bottom < box.top && self.left < box.right && self.top > box.bottom
  end

end
