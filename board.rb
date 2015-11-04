require_relative 'pawn'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'empty'

class Board
  Columns = [:A, :B, :C, :D, :E, :F, :G, :H ]

  attr_accessor :board, :valid_moves, :selected_piece_position, :selected_piece

  def initialize
    @board = Array.new(8) {Array.new(8)}
    populate
    @valid_moves = []
  end

  def populate
    @white_king = King.new([7, 4], :w, self)
    @black_king = King.new([0, 4], :b, self)
    board.each_with_index do |row, i|
      row.each_with_index do |el, j|
        generate_piece(i, j)
        # board[i][j] = King.new([i,j], col, self) if j == 4
      end
      board[7][4] = @white_king
      board[0][4] = @black_king
    end
  end

  def generate_piece(i, j)
    col = :w if i > board.length/2
    col = :b if i < board.length/2

    board[i][j] = Pawn.new([i,j], col,self) if i == 1 || i == board.length - 2
    board[i][j] = EmptyPiece.new([i,j]) if (2..(board.length - 3)).include?(i)
    if i == board.length - 1 || i == 0
      board[i][j] = Rook.new([i,j], col,self) if j == 0 || j == board.length - 1
      board[i][j] = Knight.new([i,j], col, self) if j == 1 || j == board.length - 2
      board[i][j] = Bishop.new([i,j], col, self) if j == 2 || j == board.length - 3
      board[i][j] = Queen.new([i,j], col, self) if j == 3
    end
  end

  def valid_selection?(selected_pos, turn_color) # this is good
    row = selected_pos[0]
    col = selected_pos[1]
    selected_piece = board[row][col]
    if selected_piece.color == turn_color
      return select_piece(row, col)
    end
    false
  end

  def select_piece(row, col)
    puts 'piece successfully selected'

    selected_piece = board[row][col]
    @selected_piece = selected_piece
    @selected_piece_position = [row, col]
    @valid_moves = @selected_piece.valid_moves
    "Selected: #{@selected_piece.class} @ #{Columns[col]}#{8 - row}"
  end

  def can_move_to?(selected_pos)
    piece_to_move = board[selected_pos[0]][selected_pos[1]]
    valid_move = @selected_piece.valid_moves.include?(selected_pos)
    valid_move
  end

  def is_empty_position?(selected_pos)
    board[selected_pos[0]][selected_pos[1]].is_a?(EmptyPiece)
  end

  def move_piece(selected_pos, called_by_clone = false)

    row = selected_pos[0]
    col = selected_pos[1]
    # puts "#{@selected_piece.class}: [row, col] [#{row}, #{col}]"
    board[row][col] = @selected_piece
    board[row][col].loc = [row, col]
    board[@selected_piece_position[0]][@selected_piece_position[1]] = EmptyPiece.new([@selected_piece_position[0], @selected_piece_position[1]])
    unless called_by_clone
      puts 'King in_check?'
      checkmate?
    end
    reset_selected
    true
  end

  def checkmate?
    puts "checking checkmate"
    if @black_king.checkmate? || @white_king.checkmate?
      puts 'CHECKMATE!'
      return true
    end
    false
  end

  def in_check?
    # debugger
    puts 'CALLING IN CHECK'
    puts 'Black King in Check!' if @black_king.in_check?

    puts 'White King in Check!' if @white_king.in_check?
  end

  def reset_selected
    @selected_piece = nil
    @selected_piece_position = nil
    @valid_moves = []
  end

  def king_location(color)
    return @black_king.loc if color == :b
    return @white_king.loc if color == :w
  end

  def out_of_bounds?(loc)
    loc.any? { |num| num < 0 || num >= board.length }
  end
end
