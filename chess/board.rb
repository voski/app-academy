require_relative 'piece.rb'
require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require 'byebug'
class Board

  attr_reader :grid
  def initialize(dim = 8)
    @grid = Array.new(dim) { Array.new(dim) }
    # populate
  end

  def in_check?(color)
    # find king see if any piece can get it
    king_pos = find_king(color)
    !safe?(king_pos, color)

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

    raise ArgumentError.new('NO PIECE HERE') unless self[start]

    # assuming move is valid for now
    update_piece(start, end_pos)
    update_board(start, end_pos)


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


  def populate

    # blacks
    self[[0,0]] = Rook.new([0,0], :black, self)
    self[[0,1]] = Knight.new([0,1], :black, self)
    self[[0,2]] = Bishop.new([0,2], :black, self)
    self[[0,3]] = Queen.new([0,3], :black, self)
    self[[0,4]] = King.new([0,4], :black, self)
    self[[0,5]] = Bishop.new([0,5], :black, self)
    self[[0,6]] = Knight.new([0,6], :black, self)
    self[[0,7]] = Rook.new([0,7], :black, self)

    self[[1,0]] = Pawn.new([0,0], :black, self)
    self[[1,1]] = Pawn.new([0,1], :black, self)
    self[[1,2]] = Pawn.new([0,2], :black, self)
    self[[1,3]] = Pawn.new([0,3], :black, self)
    self[[1,4]] = Pawn.new([0,4], :black, self)
    self[[1,5]] = Pawn.new([0,5], :black, self)
    self[[1,6]] = Pawn.new([0,6], :black, self)
    self[[1,7]] = Pawn.new([0,7], :black, self)










    # whites
    self[[7,0]] = Rook.new([0,0], :white, self)
    self[[7,1]] = Knight.new([0,1], :white, self)
    self[[7,2]] = Bishop.new([0,2], :white, self)
    self[[7,3]] = Queen.new([0,3], :white, self)
    self[[7,4]] = King.new([0,4], :white, self)
    self[[7,5]] = Bishop.new([0,5], :white, self)
    self[[7,6]] = Knight.new([0,6], :white, self)
    self[[7,7]] = Rook.new([0,7], :white, self)

    self[[6,0]] = Pawn.new([0,0], :white, self)
    self[[6,1]] = Pawn.new([0,1], :white, self)
    self[[6,2]] = Pawn.new([0,2], :white, self)
    self[[6,3]] = Pawn.new([0,3], :white, self)
    self[[6,4]] = Pawn.new([0,4], :white, self)
    self[[6,5]] = Pawn.new([0,5], :white, self)
    self[[6,6]] = Pawn.new([0,6], :white, self)
    self[[6,7]] = Pawn.new([0,7], :white, self)


  end

  def [](coord)
    x, y = coord
    @grid[x][y]
  end

  def []=(coord, piece)
    x, y = coord
    @grid[x][y] = piece
  end
end

board = Board.new
board[[7,6]] = King.new([7,6], :white, board)
board[[6,5]] = Rook.new([6,5], :white, board)

board[[7,4]] = King.new([7,4], :white, board)
board[[5,6]] = King.new([5,6], :white, board)
# board.in_check?(:white)
p board[[6,5]].valid_moves
# board.move([0,5], [6,6])

# p board[[6, 6]]
# p board[[6, 5 ]]
