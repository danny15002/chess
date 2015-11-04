require_relative 'piece'

class EmptyPiece < Piece
  attr_accessor :image
  def initialize(loc=0, col = nil,board = nil)
    super
    @image = "m "
    @color = col
  end


end
