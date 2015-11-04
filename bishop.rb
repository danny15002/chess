require_relative 'sliding_piece'

class Bishop < SlidingPiece

  attr_accessor :image
  BISHOP_DELTAS = [[1,1],[-1,1],[1,-1],[-1,-1]]
  def initialize(loc, col, board)
    super
    col == :b ? @image = ";30m♝" : @image = "m♝"
  end

  def valid_moves
    super(BISHOP_DELTAS)
  end

  def potential_moves
    super(BISHOP_DELTAS)
  end
end
