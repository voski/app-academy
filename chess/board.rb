require_relative 'piece.rb'
require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'
require 'byebug'
class Board

  attr_reader :grid
  def initialize(dim = 8)
    @grid = Array.new(dim) { Array.new(dim) }
  end

  def dup

    dup = Board.new
    @grid.flatten.compact.each do |piece|
      loc = piece.pos
      dup[loc] = piece
    end
    dup
  end

  def in_check?(color)
    # find king see if any piece can get it
    king_pos = find_king(color)
    !safe?(king_pos, color)
  end

  def checkmate?(color)
    if in_check?(color)
      pieces_with_moves = our_pieces(color).select { |piece| !piece.moves.empty? }
      true if pieces_with_moves.empty?
    else
      false
    end
  end

  def find_king(color)
    loc = []
    8.times do |x|
      8.times do |y|
        loc = [x, y] if @grid[x][y].is_a?(King) && @grid[x][y].color == color
      end
    end
    loc
  end

  def safe?(pos, color) # safe iff no piece  of opposing color can move here
    other_pieces = other_pieces(color)
    safe = other_pieces.none? do |piece|

      piece.moves.include?(pos)
    end

    safe
  end

  def other_pieces(color)
    if color == :black
      other_col = :white
    else
      other_col = :black
    end
    other_pieces = []
    8.times do |x|
      8.times do |y|
        other_pieces << @grid[x][y] if !@grid[x][y].nil? && @grid[x][y].color == other_col
      end
    end

    other_pieces
  end

  def our_pieces(color)
    our_pieces = []
    8.times do |x|
      8.times do |y|
        our_pieces << @grid[x][y] if !@grid[x][y].nil? && @grid[x][y].color == color
      end
    end

    our_pieces
  end


  def move(start, end_pos)
    s_x , s_y = start
    e_x , e_y = end_pos
    # p start
    end_piece = self[end_pos]
    start_piece = self[start]
    raise ArgumentError.new('NO PIECE HERE') unless start_piece
    raise ArgumentError.new('THAT MOVE PUTS YOU IN CHECK') if start_piece.move_into_check?(end_pos)


    if start_piece.moves.include?(end_pos)
      if !start_piece.is_a?(Pawn)
        update_piece(start, end_pos)
        update_board(start, end_pos)
        start_piece.toggle_moved unless start_piece.moved
      else
        if start_piece.attack_moves.include?(end_pos) && start_piece.enemy?(end_piece)
          update_piece(start, end_pos)
          update_board(start, end_pos)
          start_piece.toggle_moved unless start_piece.moved
        elsif start_piece.straight_moves.include?(end_pos) && !start_piece.enemy?(end_piece) # move straight
          update_piece(start, end_pos)
          update_board(start, end_pos)
          start_piece.toggle_moved unless start_piece.moved
        else
          raise ArgumentError.new("Invalid move")
        end

      end
    else
      raise ArgumentError.new("Invalid move")
    end

  end

  def update_board(start, end_pos)
    s_x , s_y = start
    e_x , e_y = end_pos
    @grid[e_x][e_y] = @grid[s_x][s_y]
    @grid[s_x][s_y] = nil
  end

  def update_piece(start, end_pos)
    s_x , s_y = start
    @grid[s_x][s_y].pos = end_pos
  end

  def populate_pawns(color)
    if color == :black
      8.times do |num|
        self[[1,num]] = Pawn.new([1,num], color, self)
      end
    else
      8.times do |num|
        self[[6,num]] = Pawn.new([1,num], color, self)
      end
    end
  end

  def populate
    # blacks
    populate_pawns(:black)
    self[[0,0]] = Rook.new([0,0], :black, self)
    self[[0,1]] = Knight.new([0,1], :black, self)
    self[[0,2]] = Bishop.new([0,2], :black, self)
    self[[0,3]] = Queen.new([0,3], :black, self)
    self[[0,4]] = King.new([0,4], :black, self)
    self[[0,5]] = Bishop.new([0,5], :black, self)
    self[[0,6]] = Knight.new([0,6], :black, self)
    self[[0,7]] = Rook.new([0,7], :black, self)

    # whites
    populate_pawns(:white)
    self[[7,0]] = Rook.new([0,0], :white, self)
    self[[7,1]] = Knight.new([0,1], :white, self)
    self[[7,2]] = Bishop.new([0,2], :white, self)
    self[[7,3]] = Queen.new([0,3], :white, self)
    self[[7,4]] = King.new([0,4], :white, self)
    self[[7,5]] = Bishop.new([0,5], :white, self)
    self[[7,6]] = Knight.new([0,6], :white, self)
    self[[7,7]] = Rook.new([0,7], :white, self)
  end

  def [](coord)
    x, y = coord
    @grid[x][y]
  end

  def []=(coord, piece)
    x, y = coord
    @grid[x][y] = piece
  end

  def display
    dis_s =  "   a  b  c  d  e  f  g  h"
    grid.each_with_index do |row, index|
      dis_s += " \n #{index + 1}"
      row.each_with_index do |col, index2|
        if col.render.nil?
          dis_s += "   "
        else
          dis_s += " #{col.render} "
        end
      end

    end
     puts dis_s
  end

end
class NilClass
  def render
    " "
  end
end

board = Board.new

board.populate
# board.move([0,1],[2,0])

# board[[3,4]] = Queen.new([3,4], :black, board)
# board[[3,5]] = King.new([3,5], :white, board)
# board[[2,6]] = Queen.new([3,6], :black, board)



board.display
# p board.check_mate?(:white)
# board.move([3,5], [1,3])
# board.display
 board.move([1,3], [3,3])
 board.display

# board[[7,4]] = King.new([7,4], :white, board)
# board[[5,6]] = King.new([5,6], :white, board)
# board.in_check?(:white)
# p board[[6,5]].valid_moves
# board.move([0,5], [6,6])

# p board[[6, 6]]
# p board[[6, 5 ]]
