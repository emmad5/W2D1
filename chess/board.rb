require_relative "piece"
class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    populate
  end
  
  def populate  
    self[[0,3]], self[[7,3]] = Piece.new("Queen"), Piece.new("Queen")
    self[[0,4]], self[[7,4]] = Piece.new("King"), Piece.new("King")
    self[[0,0]], self[[0,7]], self[[7,0]], self[[7,7]] = Piece.new("Rook"), Piece.new("Rook"), Piece.new("Rook"), Piece.new("Rook")
    self[[0,1]], self[[0,6]], self[[7,1]], self[[7,6]] = Piece.new("Knight"), Piece.new("Knight"), Piece.new("Knight"), Piece.new("Knight") 
    self[[0,2]], self[[0,5]], self[[7,2]], self[[7,5]] = Piece.new("Bishop"), Piece.new("Bishop"), Piece.new("Bishop"), Piece.new("Bishop")
    (0..7).each do |i|
      self[[1, i]] = Piece.new("Pawn")
    end
    (0..7).each do |i|
      self[[6, i]] = Piece.new("Pawn")
    end  
  end
  
  def move_piece(start_pos, end_pos)
    raise "There is no piece at #{start_pos}" if self[start_pos].nil?
    raise "The piece cannot move to #{end_pos}" unless self[end_pos].nil?
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = nil
  end
  
  def [](pos)
    row, col = pos
    @board[row][col]
  end
  
  def []=(pos, mark)
    row, col = pos
    @board[row][col] = mark
  end
end