class Piece
  attr_accessor :pos

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def moves

  end

  def valid_move?(pos)
    x,y = pos
    x.between?(0,7) || y.between?(0,7)
  end


end
