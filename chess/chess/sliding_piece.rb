class SlidingPiece < Piece

  def initialize(options={})
    super
    @diagonal
    @horizontal
    @both
  end

  def moves(direction)
    moves = []
    SLIDE_DOWN = [0, -1]
    SLIDE_UP =    [0 ,1]
    SLIDE_LEFT = [-1, 0]
    SLIDE_RIGHT = [1, 0]

    generate = true
    while generate
      case direction
      when :diagonal

      when :horizontal


      end

      else

      end

    end

  end

  def slide_right
    move_right = []
    x, y = self.pos

    until !(x.between?(0,6))
      x += 1
      move_right << [x, y]
    end

    move_right
  end

  def slide_left
    move_left = []
    x, y = self.pos

    until !(x.between?(1,7))
      x -= 1
      move_left << [x, y]
    end

    move_left
  end


  def slide_up
    move_up = []
    x, y = self.pos

    until !(y.between?(0,6))
      y += 1
      move_up << [x, y]
    end

    move_up
  end

  def slide_down
    move_down = []
    x, y = self.pos

    until !(y.between?(1,7))
      y -= 1
      move_down << [x, y]
    end

    move_down
  end


  def slide_up_right
    move_ur = []
    x, y = self.pos

    until !(y.between?(0,6)) || !(x.between?(0,6))
      y += 1
      x += 1
      move_ur << [x, y]
    end
    
    move_ur
  end

  def slide_up_left
    move_ul = []
    x, y = self.pos

    until !(y.between?(0,6)) || !(x.between?(1,7))
      y += 1
      x -= 1
      move_ul << [x, y]
    end

    move_ul
  end

  def slide_down_left
    move_dl = []
    x, y = self.pos

    until !(y.between?(1,7)) || !(x.between?(1,7))
      y -= 1
      x -= 1
      move_dl << [x, y]
    end

    move_dl
  end

  def slide_down_right
    move_dr = []
    x, y = self.pos

    until !(y.between?(1,7)) || !(x.between?(0,6))
      y -= 1
      x += 1
      move_dr << [x, y]
    end

    move_dr
  end

end


class Bishop < SlidingPiece
  attr_accessor direction
  def initialize
    super
    @direction
  end

  def move_dir
    direction
  end



end


board = Baord.new
