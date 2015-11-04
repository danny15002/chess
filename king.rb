require_relative 'stepping_piece'

class King < SteppingPiece
  attr_accessor :image
  KING_DELTAS = [[1, 1], [-1 , 1], [1, -1], [-1, -1], [1, 0],[-1,0],[0,1],[0,-1]]
  def initialize(loc, col, board)
    super
    col == :b ? @image = ';30m♚' : @image = 'm♚'
  end

  def valid_moves
    super(KING_DELTAS)
  end

  def potential_moves
    super(KING_DELTAS)
  end

  def in_check?
    generate_enemy_move_list.include?(loc)
  end

  def checkmate?
    list = []
    find_enemies.each do |enemy|
      list << enemy.valid_moves
    end
    list.flatten.empty?
  end
end
