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
  def initialize
    @origin = [0, 0]
  end

  def possible_moves(start, result = [])
    #all 8 moves knight can make from any start position
    moves = [[2, 1], [2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]].freeze
    moves.each do |move|
        #determine possible destinations based on start argument and possible moves
        destination = [(move[0] + start[0]), (move[1] + start[1])]
        #only push moves that are on 8x8 board
        result << destination if destination[0].between?(0, 7) && destination[1].between?(0, 7)
    end
    result
  end

  def make_tree(destination, depart = @origin)
    queue = [Knight.new(depart)]
    current = queue.shift
    until current.location == destination
        moves = possible_moves(current.location)
        moves.each do |move|
            node = Knight.new(move, current)
            queue << node
            current.children << node
        end
        current = queue.shift
    end
    current
  end
end

board = Board.new
p board.make_tree([3,3])