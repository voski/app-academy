require_relative 'piece.rb'
require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'
require_relative 'pawn.rb'
require_relative 'board.rb'
require 'byebug'

class Game


  def initialize
    @game_board = Board.new
  end

  def play
    @game_board.populate
    until won?
      display
      start, dest = HumanPlayer.get_move
      @game_board.move(start, dest)
      display
    end
  end

  def display
    @game_board.display
  end
  def won?
    @game_board.checkmate?(:white) || @game_board.checkmate?(:black)
  end
end


class HumanPlayer

  MOVE_HASH = {'A' => 0,
                'B' => 1,
                'C' => 2,
                'D' => 3,
                'E' => 4,
                'F' => 5,
                'G' => 6,
                'H' => 7,
              }

  def self.get_move
    p 'Pick start'
    start_pre = gets.chomp.upcase
    start = [(start_pre[1].to_i - 8).abs, MOVE_HASH[start_pre[0]] ]
    p 'Pick destination'
    dest_pre = gets.chomp.upcase
    dest = [(dest_pre[1].to_i - 8).abs, MOVE_HASH[dest_pre[0]]]

    [start, dest]
  end
end

g = Game.new
g.play
