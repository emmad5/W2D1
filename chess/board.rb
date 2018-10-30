require_relative "piece"
class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @board[0,3], @board[7,3] = Piece.new("Queen")
    @board[0,4], @board[7,4] = Piece.new("King")
    @board[0,0], @board[0,7], @board[7,0], @board[7,7] = Piece.new("Rook")
    @board[0,1], @board[0,6], @board[7,1], @board[7,6] = Piece.new("Knight")
    @board[0,2], @board[0,5], @board[7,2], @board[7,5] = Piece.new("Bishop")
    (0..7).each do |i|
      @board[1, i] = Piece.new("Pawn")
    end
    (0..7).each do |i|
      @board[6, i] = Piece.new("Pawn")
    end
      
  end
  
  
  def move_piece(start_pos, end_pos)
    raise "There is no piece at #{start_pos}" if @board[start_pos].nil?
    raise "The piece cannot move to #{end_pos}" unless @board[end_pos].nil?
    piece = @board[start_pos]
    @board[end_pos] = piece
    @board[start_pos] = nil
  end
  
  def [](pos)
    row, col = pos
    @board[row][col]
  end
  
  def []=(pos, mark)
    @board[pos] = mark
  end
end