#create data structure where children point back to parent, and parent keeps record of children
class Knight
  attr_reader :location, :parent
  attr_accessor :children
  def initialize (location, parent = nil)
    @location = location
    @parent = parent
    @children = []
  end
end

class Board
  public
  #this method ties all previous methods together and is only thing user interacts with
  def knight_moves(start, destination)
    last_knight = make_tree(destination, start)
    history = trace_back(last_knight, start)
    produce_output(history)
  end
  
  private
  #defines how a knight can move and returns array of possible moves that land on 8x8 board
  def possible_moves (start, result = [])
    moves = [[2, 1], [2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
    moves.each do |move|
      destination = [(move[0] + start[0]), (move[1] + start[1])]
      result << destination if destination[0].between?(0, 7) && destination[1].between?(0, 7)
    end
    result
  end

  #builds data structure breadth first stopping once a knight is found at desired destination, returns final knight node
  def make_tree (destination, start)
    queue = [Knight.new(start)]
    current = queue.shift
    until current.location == destination do
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

  #takes final knight node from make_tree and traces back through parents to arrive back at start, returns locations of knights along path
  def trace_back(current, start, history = [])
    until current.location == start do
      history << current.location
      current = current.parent
    end
    history << current.location
    history
  end

  #produces output for knight moves method
  def produce_output(history)
    puts "You made it in #{history.length} moves!  Here's your path:"
    history.reverse.each { |move| p move}
  end
end

board = Board.new
board.knight_moves([0,0], [6,7])