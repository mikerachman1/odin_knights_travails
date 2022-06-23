class Knight
  attr_reader :location, :parent
  attr_accessor :children

  def initialize(data, parent = nil)
    @location = data
    @children = []
    @parent = parent
  end
end

class Board
  def initialize; end

  def possible_moves(start, result = [])
    #all moves knight can make
    moves = [[2, 1], [2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]].freeze
    moves.each do |move|
        #determine possible destinations based on start argument and possible moves
        destination = [(move[0] + start[0]), (move[1] + start[1])]
        #only push moves that are on 8x8 board
        result << destination if destination[0].between?(0, 7) && destination[1].between?(0, 7)
    end
    result
  end
end

board = Board.new
p board.possible_moves([5,6])