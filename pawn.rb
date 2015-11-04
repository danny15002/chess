require_relative 'stepping_piece'

class Pawn < SteppingPiece
  attr_accessor :image
  def initialize(loc, col, board)
    super
    col == :b ? @image = ";30m♟" : @image = "m♟"
    col == :b ? @start_row = 1 : @start_row = 6
    @moves = 0
  end

  def valid_moves
    super([])
  end

  def attacking_moves
    color == :w ? dir = -1 : dir = 1
    attacking_list = []
    unless out_of_bounds?(arr_add(loc, [1 * dir, 1]))
      attacking_list << arr_add(loc, [1 * dir, 1]) if enemy_at?(arr_add(loc, [1 * dir, 1]))
    end
    unless out_of_bounds?(arr_add(loc, [1 * dir, -1]))
      attacking_list << arr_add(loc, [ 1 * dir, -1]) if enemy_at?(arr_add(loc, [1 * dir, -1]))
    end
    attacking_list
  end

  def potential_moves
    color == :w ? dir = -1 : dir = 1
    potential_list = []
    potential_list += super([[1 * dir, 0]]) unless enemy_at?(arr_add(loc, [1 * dir, 0]))
    unless enemy_at?(arr_add(loc, [2 * dir, 0]))
      potential_list += super([[2 * dir, 0]]) if @start_row == loc[0] && potential_list.include?(arr_add(loc, [1 * dir, 0]))
    end
    potential_list += attacking_moves
    potential_list
  end
end
