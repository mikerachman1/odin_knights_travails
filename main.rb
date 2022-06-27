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

  def build_tree(destination, start = @origin)
    queue = [Knight.new(start)]
    current = queue.shift
    until current.location == destination do
      moves = possible_moves(current.location)
      moves.each do |move|
        node = Knight.new(move, current) #Create new knight node for each possible move of parent current
        queue << node #add child to queue
        current.children << node #add child to parent's chidren array
      end
      current = queue.shift
    end
    current
  end

  def trace_back(current, start, history = [])
    until current.location == start do
      history << current
      current = current.parent
    end
    history << current
    history
  end

  def produce_output(history)
    puts "You made it in #{history.length} moves! Here's your path:"
    history.each { |move| p move}
  end

end

board = Board.new
p board.make_tree([3,3])