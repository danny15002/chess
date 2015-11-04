require_relative 'piece'

class SteppingPiece < Piece

  def valid_moves(deltas)
    super(potential_moves)
  end

  def potential_moves(deltas)
    potential_list = []
    deltas.each do |delta|
      obstacle_hit = false
      curr_pos = arr_add(loc, delta)
      if out_of_bounds?(curr_pos)
        curr_pos = loc
        next
      end
      same_color_piece = board.board[curr_pos[0]][curr_pos[1]].color == color
      potential_list << curr_pos unless same_color_piece
      curr_pos = loc
    end
    potential_list
  end
end
