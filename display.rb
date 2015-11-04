require_relative "Cursorable"


class Display
  include Cursorable
  attr_accessor :board, :cursor_pos
  def initialize(board = Board.new)
    @board = board
    @cursor_pos = [0, 0]
    @selected_pos = nil
    @valid_list = []
  end

  def renders(*args)
    system 'clear'
    puts ' A B C D E F G H'
    0.upto(board.board.length - 1) do |i|
      print "#{8 - i}"
      0.upto(board.board.length - 1) do |j|

        if board.selected_piece_position == [i,j]
          print "\033[45#{board.board[i][j].image} \033[0m"
        elsif cursor_pos == [i,j]
          print "\033[105#{board.board[i][j].image} \033[0m"
        elsif i.even? == j.even?
          if board.valid_moves.include?([i,j])
            print "\033[106#{board.board[i][j].image} \033[0m"
          else
            print "\033[104#{board.board[i][j].image} \033[0m"
          end
        else
          if board.valid_moves.include?([i,j])
            print "\033[46#{board.board[i][j].image} \033[0m"
          else
            print "\033[44#{board.board[i][j].image} \033[0m"
          end
        end
      end
      puts ""
    end
    puts cursor_pos.to_s
    args.each { |arg| puts arg }
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end


end
