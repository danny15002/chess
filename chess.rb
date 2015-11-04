require_relative 'display'
require_relative 'board'
require 'byebug'

# chess class to run chess game
class Chess
  attr_reader :display, :board, :turn_color

  def self.play_chess
    board = Board.new
    display = Display.new(board)
    chess_game = Chess.new(display, board)
  end

  def initialize(display, board)
    @display = display
    @board = board
    @turn_color = :w
    @player_active = false
  end

  def run
    result = nil
    cursor_pos = nil
    until board.checkmate?
      display.renders()
      unless cursor_pos.nil?
        puts "#run selection: #{board.board[cursor_pos[0]][cursor_pos[1]].color} your color: #{turn_color}"
      end
      cursor_pos = display.get_input
      if cursor_pos
        process_input(cursor_pos) if board.valid_selection?(cursor_pos, turn_color)
      end
    end
    puts "White Wins!" if turn_color == :b
    puts "Black Wins!" if turn_color == :w
    puts 'GAME OVER'
  end

  def process_input(initial_cursor)
    display.renders
    selection_made = false
    until selection_made # runs if selection_made is false
      cursor_pos = display.get_input
      display.renders
      if cursor_pos
        puts 'selection_made'
        if board.can_move_to?(cursor_pos)
          board.move_piece(cursor_pos)
          swap_players
          selection_made = true
          display.renders
          puts 'piece moved!'
        elsif board.is_empty_position?(cursor_pos)
          board.reset_selected
          puts 'empty selected'
          selection_made = true
        else
          display.renders(board.valid_selection?(cursor_pos, turn_color))
        end
      end
    end
  end


  def process_inputttt(cursor)
    row = cursor[0]
    col = cursor[1]
    another_selection = false
    move_to = true
    unless board.board[row][col].is_a? EmptyPiece
      selected_pos = cursor.dup

      valid_list = board.select_piece(row,col)
      until another_selection && move_to
        renders


        another_selection = get_input
        move_to = board.move_piece(another_selection[0],another_selection[1]) unless another_selection.nil?
      end
      @selected_pos = nil
      @valid_list  = []
    end
  end

  def swap_players
    if @turn_color == :w
      @turn_color = :b
    else
      @turn_color = :w
    end
  end

end


game = Chess.play_chess
game.run
