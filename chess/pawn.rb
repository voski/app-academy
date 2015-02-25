class Pawn < Piece
  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2659" : @uni = "\u265F"

  end
  def moves
    straight_moves + diagonal_moves
  end

  def straight_moves
    x, y = pos
    if self.color == :white
      if @moved
        possible_moves = [[x - 1, y]]
      elsif board[[x - 1, y]].nil?
        possible_moves = [[x - 1, y], [x - 2, y]]
      else
        possible_moves = []
      end
    else
      if @moved
        possible_moves = [[x + 1, y]]
      elsif board[[x + 1, y]].nil?
        possible_moves = [[x + 1, y],[x + 2, y]]
      else
        possible_moves = []
      end
    end

    valid_moves = possible_moves.select { |move| !off_board?(move) && !ally?(board[move]) }
    valid_moves
  end

  def diagonal_moves
    x, y = pos
    if self.color == :white
      possible_moves = [
        [x - 1, y + 1],
        [x - 1, y - 1]]
    else
      possible_moves = [
        [x + 1, y + 1],
        [x + 1, y - 1]]
    end
  end



  def attack_moves
    attack_moves = []
    diagonal_moves.each do |move|
      attack_moves << move if board.other_pieces(color).include?(board[move])
    end
    attack_moves
  end

end
