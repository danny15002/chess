require_relative 'piece'

class SlidingPiece < Piece
  def valid_moves(deltas)
    super(potential_moves)
  end

  def potential_moves(deltas)
    potential_list = []
    deltas.each do |delta|
      curr_pos = arr_add(loc,delta)
      out_bounds = curr_pos.any? {|el| el < 0 || el >= board.board.length}
      if out_bounds
        curr_pos = loc
        next
      end
      collision = !board.board[curr_pos[0]][curr_pos[1]].is_a?(EmptyPiece)
      until out_bounds || collision
        potential_list << curr_pos
        curr_pos = arr_add(curr_pos, delta)
        out_bounds = curr_pos.any? {|el| el < 0 || el >= board.board.length}
        unless out_bounds
          collision = !board.board[curr_pos[0]][curr_pos[1]].is_a?(EmptyPiece)
        end
      end
      unless out_of_bounds?(curr_pos)
        potential_list << curr_pos unless board.board[curr_pos[0]][curr_pos[1]].color == color
      end
      curr_pos = loc
    end
    potential_list
  end

  def filter_moves(valid_list)
  end
end
