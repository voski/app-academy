class Piece
  attr_accessor :pos, :color, :board
  attr_reader :moved

  def render
    @uni.encode("UTF-8")
  end

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @moved = false
  end

  def moves

  end



  def off_board?(pos)
    x, y = pos
    !x.between?(0,7) || !y.between?(0,7)
  end

  def ally?(piece)
    return false if piece.nil?
    @color == piece.color
  end

  def enemy?(piece)
    return false if piece.nil?
    @color != piece.color
  end

  def toggle_moved
    !@moved
  end

  def move_into_check?(dest) # => go to pos

    dup = board.dup
    dup[dest] , dup[pos] = dup[pos], nil

    dup.in_check?(color)
  end


end
