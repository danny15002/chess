require_relative 'sliding_piece'

class Rook < SlidingPiece

  attr_accessor :image
  ROOK_DELTAS =  [[1,0],[-1,0],[0,1],[0,-1]]
  def initialize(loc, col, board)
    super
    col == :b ? @image = ";30m♜" : @image = "m♜"
    # \033[38m♜ \033[0m

  end

  def valid_moves
    super(ROOK_DELTAS)
  end

  def potential_moves
    super(ROOK_DELTAS)
  end
end
