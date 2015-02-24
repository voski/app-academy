class Tile
  NEIGHBORS = [[-1, 1],
               [-1, 0],
               [-1, -1],
               [0, -1],
               [0, 1],
               [1, 1],
               [1, 0],
               [1, -1]]

  attr_accessor :board, :flagged, :explored, :has_bomb
  attr_reader   :coords

  def initialize(
    coords, board = nil, flagged = false,
    explored = false, has_bomb = false
    )
    @coords, @board, @flagged, @explored, @has_bomb =
    coords, board, flagged, explored, has_bomb

  end

  # def initialize(coords, status = nil, board = nil, has_bomb = false)
  #   @coords, @status, @board, @has_bomb = coords, status, board, has_bomb
  # end

  def status
    # byebug if neighbor_bomb_count > 0
    if @flagged
      "F"
    elsif @explored && !@has_bomb
      if neighbor_bomb_count > 0
        "#{neighbor_bomb_count}"
      else
        "_"
      end
    else
      "*"
    end
  end

  def flag
    @flagged = true
    @explored = true
  end

  def unflag
    @flagged = false
    @explored = false
  end

  def reveal
    @explored = true

    if no_neighboring_bombs?(@coords)
      neighbors.each do |neighbor_coords|
        neighbor_tile = @board[neighbor_coords]
        neighbor_tile.reveal if !neighbor_tile.explored
      end
    end
  end

  def no_neighboring_bombs?(pos)
    @board[pos].neighbors.all? do |neighbor_coords|
      !@board[neighbor_coords].has_bomb
    end
  end

  def neighbors
    poss_neighbors.select { |poss_neighbor| valid_neighbor?(poss_neighbor) }
    #this will return neighboring tiles as tile classes
  end

  def poss_neighbors
    NEIGHBORS.map do |neighbor|
      [neighbor[0] + coords[0], neighbor[1] + coords[1]]
    end
  end

  def valid_neighbor?(neighbor_coords)
    neighbor_coords.all? do |coords|
      coords.between?(0, 8)
    end
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor_coords|
      count += 1 if @board[neighbor_coords].has_bomb
    end
    count
  end
end

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) { [] } }

    set_initial_board
    set_bombs
  end

  def set_initial_board
    @grid.each_index do |i|
      @grid[0].each_index do |j|
        @grid[i][j] = Tile.new([i, j], self)
      end
    end
  end

  def render
    board_string = (0..8).to_a.join("\t") + "\n"

    @grid.each_index do |i|
      @grid[0].each_index do |j|
        board_string += @grid[i][j].status + "\t"
      end

      board_string += "#{i}\n"
    end

    puts board_string
  end

  def [](coord)
    x, y = coord[0], coord[1]
    @grid[x][y]
  end

  def random_coords(count = 10)
    coords = []
    until coords.length == count do
      poss_coord = [rand(@grid.length), rand(@grid[0].length)]
      coords << poss_coord unless coords.include?(poss_coord)
    end
    coords
  end

  def set_bombs
    random_coords.each do |coord|
      self[coord].has_bomb = true
    end
  end

  def won?
    explored_tiles_counter = 0

    @grid.each_index do |i|
      @grid[0].each_index do |j|
        tile = @grid[i][j]
        explored_tiles_counter += 1 if tile.explored
      end
    end

    total_num_tiles = @grid.length * @grid[0].length

    explored_tiles_counter == total_num_tiles
  end

end

class Game
  def initialize

  end

  def play
    puts 'Welcome to Minesweeper'
    puts 'would you like to load a game?'
    if gets.chomp == 'y'
      #load
    else
      # play new game
      @this_game_board = Board.new

      until @this_game_board.won?
        @this_game_board.render

        puts
        puts 'Please pick a tile "#{row}, #{column}" row, column:(0-8)'

        tile_coords = gets.chomp.split(", ").map(&:to_i)
        tile = @this_game_board[tile_coords]

        puts 'Would you like to Flag, Reveal, or Unflag? (F/R/U)'
        which_move = gets.chomp.upcase

        if which_move == 'R'
          if tile.has_bomb
            puts "You lose."
            return
          else
            tile.reveal
          end
        elsif which_move == 'F'
          tile.flag
        elsif which_move == 'U'
          tile.unflag
        else
          puts 'Invalid move try again F and R only!'
        end
      end
    end

    puts "Congratulations! You won."
  end
end
