class SteppingPiece < Piece

end


class King < SteppingPiece

  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2654" : @uni = "\u265A"
  end

  def moves
    x, y = pos
    possible_moves = [
      [x+1, y+1],
      [x-1, y+1],
      [x+1, y-1],
      [x-1, y-1],
      [x, y+1],
      [x, y-1],
      [x-1, y],
      [x-1, y] ]

      valid_moves = possible_moves.select { |move| !off_board?(move) && !ally?(board[move]) && !self.move_into_check?(move) }



    end
end

class Knight < SteppingPiece

  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2658" : @uni = "\u265E"
  end
  def moves
    x, y = pos
    possible_moves = [
      [x+2, y+1],
      [x-2, y+1],
      [x+2, y-1],
      [x-2, y-1],
      [x+1, y+2],
      [x+1, y-2],
      [x-1, y-2],
      [x-1, y+2] ]
    valid_moves = possible_moves.select { |move| !off_board?(move) && !ally?(board[move]) }
    valid_moves
  end
end
