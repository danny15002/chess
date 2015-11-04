require_relative 'sliding_piece'

class Queen < SlidingPiece

  attr_accessor :image
  QUEEN_DELTAS = [[1,1],[-1,1],[1,-1],[-1,-1],[1,0],[-1,0],[0,1],[0,-1]]
  def initialize(loc, col, board)
    super
    col == :b ? @image = ";30m♛" : @image = "m♛"
  end

  def valid_moves
    super(QUEEN_DELTAS)
  end

  def potential_moves
    super(QUEEN_DELTAS)
  end
end
