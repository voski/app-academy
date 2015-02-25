class Pawn < Piece
  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2659" : @uni = "\u265F"
  end

  def valid_moves
    x, y = pos
    if self.color == :white
      possible_moves_wht = [
        [x - 1, y + 1],
        [x - 1, y - 1],
        [x - 1, y],
        [x - 2, y],]
    else
      possible_moves_blk = [
        [x + 1, y + 1],
        [x + 1, y - 1],
        [x + 1, y],
        [x + 2, y],]
    end

    valid_moves = possible_moves.select { |move| !off_board?(move) && !ally?(board[move]) }
    valid_moves
  end
end
