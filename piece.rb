# Super class for all chess pieces
require 'deep_clone'
require 'byebug'
# super class that controls piece behavior
class Piece
  attr_accessor :loc, :color, :board
  def initialize(loc,col,board)
    @loc = loc
    @color = col
    @board = board
    @selectable = true
  end

  def valid_moves(potential_moves)

    valid_move_list = []
    # puts "#{self.class} with potential_moves: #{potential_moves}"
    potential_moves.each do |move|
      cloned_board = DeepClone.clone(board)
      cloned_board.selected_piece = DeepClone.clone(self)
      cloned_board.selected_piece_position = self.loc.dup
      cloned_board.move_piece(move, true)
      # puts "move in potential_moves:#{move}"
      clone_piece = cloned_board.board[move[0]][move[1]]
      # puts "clone piece #{clone_piece.class} @ #{clone_piece.loc}"
      enemy_move_list = clone_piece.generate_enemy_move_list
      unless enemy_move_list.include?(cloned_board.king_location(color))
        valid_move_list << move
      end
    end

    valid_move_list
  end

  def find_enemies
    enemies = []
    board.board.each do |row|
      row.each do |piece|
        enemies << piece if piece.color != color && !piece.color.nil?
      end
    end
    enemies
  end

  def generate_enemy_move_list
    enemy_moves = []
    find_enemies.each do |enemy|
      enemy_moves += enemy.potential_moves
    end
    enemy_moves
  end

  def out_of_bounds?(loc)
    loc.any? { |num| num < 0 || num >= board.board.length }
  end

  def arr_add(a, b)
    c = []
    a.each_index { |i| c << a[i] + b[i] }
    c
  end

  def enemy_at?(loc)
    board.board[loc[0]][loc[1]].color != color && !board.board[loc[0]][loc[1]].color.nil?
  end

  def deep_dup(board)
    dup_board = []
    board.each { |row| dup_board << row.dup }
    dup_board
  end


end
