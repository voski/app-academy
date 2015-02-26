require_relative 'piece.rb'
class SlidingPiece < Piece


  def moves
    moves = []
    vectors = self.class::VECTORS
    vectors.each do |vector|
      current_x, current_y = pos
      vector_x, vector_y = vector
      scalor = 1
      new_x = current_x + (vector_x * scalor)
      new_y = current_y + (vector_y * scalor)
      # debugger
       while !off_board?([new_x, new_y]) && !ally?(board.grid[new_x][new_y])
        moves << [new_x, new_y]
        if enemy?(board.grid[new_x][new_y])
          break
        end
        scalor += 1
        new_x = current_x + (vector_x * scalor)
        new_y = current_y + (vector_y * scalor)

      end
      moves
    end

    moves
  end

end

class Bishop < SlidingPiece
  attr_accessor :direction
  attr_reader :VECTORS
  VECTORS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2657" : @uni = "\u265D"
  end


end

class Rook < SlidingPiece
  attr_accessor :direction
  attr_reader :VECTORS
  VECTORS = [[1, 0], [0, 1], [0, -1], [-1, 0]]

  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2656" : @uni = "\u265C"
  end

end

class Queen < SlidingPiece
  attr_accessor :direction
  attr_reader :VECTORS
  VECTORS = [[1, 0], [0, 1], [0, -1], [-1, 0], [1, 1], [-1, 1],[1, -1], [-1, -1]]
  def initialize(pos, color, board)
    super
    color == :white ? @uni = "\u2655" : @uni = "\u265B"
  end


end
#
