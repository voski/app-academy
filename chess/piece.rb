class Piece
  attr_accessor :pos, :color, :board

  def render
    @uni.encode("UTF-8")
  end

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
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



end
