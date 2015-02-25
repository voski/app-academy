class SteppingPiece < Piece

end


class King < SteppingPiece

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

      valid_moves = possible_moves.select { |move| valid_move?(move) }

      valid_moves
    end

end

class Knight < SteppingPiece

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

    valid_moves = possible_moves.select { |move| valid_move?(move) }

    valid_moves
  end
end
