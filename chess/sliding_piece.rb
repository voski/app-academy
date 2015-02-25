require_relative 'piece.rb'
class SlidingPiece < Piece


  def moves #:diag :horiz :both
    moves = []
    case direction
    when :diagonal
      moves = (slide_up_right + slide_up_left + slide_down_right + slide_down_left)
    when :horizontal
      moves = (slide_right + slide_up + slide_left + slide_down)
    when :both
      moves =
            (slide_up_right + slide_up_left + slide_down_right + slide_down_left +
            slide_right + slide_up + slide_left + slide_down)
    end

    moves
  end

  private

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
  attr_accessor :direction

  def initialize(pos, color, board)
    super
    @direction = :diagonal
  end

  def valid_moves
    moves = self.moves
    moves.each do |pot_move|
      if board[pot_move]
        moves.delete(pot_move) if board[pos].ally?(board[pot_move])
      end
    end
    moves
  end
end

class Rook < SlidingPiece
  attr_accessor :direction

  def initialize(pos, color, board)
    super
    @direction = :horizontal
  end
end

class Queen < SlidingPiece
  attr_accessor :direction

  def initialize(pos, color, board)
    super
    @direction = :both
  end
end
