require_relative "piece"
class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    self[[0,3]], self[[7,3]] = Queen.new('white', @board, ([0, 3])), Queen.new('black', @board, ([7, 3]))
    self[[0,4]], self[[7,4]] = King.new('white', @board, ([0, 4])), King.new('black', @board, ([7, 4]))
    self[[0,0]], self[[0,7]] = Rook.new('white', @board, ([0, 0])), Rook.new('white', @board, ([0, 7]))
    self[[7,0]], self[[7,7]] = Rook.new('black', @board, ([7, 0])), Rook.new('black', @board, ([7, 7]))
    self[[0,1]], self[[0,6]] = Knight.new('white', @board, ([0, 1])), Knight.new('white', @board, ([0, 6]))
    self[[7,1]], self[[7,6]] = Knight.new('black', @board, ([7, 1])), Knight.new('black', @board, ([7, 6]))
    self[[0,2]], self[[0,5]] = Bishop.new('white', @board, ([0, 2])), Bishop.new('white', @board, ([0, 5]))
    self[[7,2]], self[[7,5]] = Bishop.new('black', @board, ([7, 2])), Bishop.new('black', @board, ([7, 5]))
    (0..7).each do |i|
      self[[1, i]] = Pawn.new('white', @board, ([1, i]))
    end
    (0..7).each do |i|
      self[[6, i]] = Pawn.new('black', @board, ([6, i]))
    end

    self.board.each_with_index do |row, i|
      row.each_with_index do |pos, j|
        if pos.nil?
          self[[i, j]] = Null_Piece.instance
        end
      end
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

  def valid_pos?(pos)
    return false if (pos[0] < 0 || pos[0] > 7) || (pos[1] < 0 || pos[1] > 7)
    true
  end
end
