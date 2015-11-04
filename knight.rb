require_relative 'stepping_piece'

class Knight < SteppingPiece
  attr_accessor :image
  KNIGHT_DELTAS = [[1, 2], [-1, 2], [1, -2], [-1, -2],
                   [2, 1], [-2, 1], [2, -1], [-2, -1]]
  def initialize(loc, col, board)
    super
    col == :b ? @image = ";30m♞" : @image = "m♞"
  end

  def valid_moves
    super(KNIGHT_DELTAS)
  end

  def potential_moves
    super(KNIGHT_DELTAS)
  end
end
