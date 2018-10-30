require "colorize"
require "singleton"
require "byebug"

class Piece
  attr_reader :piece

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves

  end

  # def inspect
  #   case @piece
  #   when "King" then "♔"
  #   when "Queen" then "♕"
  #   when "Rook" then "♖"
  #   when "Knight" then "♘"
  #   when "Bishop" then "♗"
  #   when "Pawn" then "♙"
  #   end
  # end
  #
  # def to_s
  #   case @piece
  #   when "King" then " ♔ ".colorize(:color => :black)
  #   when "Queen" then " ♕ ".colorize(:color => :black)
  #   when "Rook" then " ♖ ".colorize(:color => :black)
  #   when "Knight" then " ♘ ".colorize(:color => :black)
  #   when "Bishop" then " ♗ ".colorize(:color => :black)
  #   when "Pawn" then " ♙ ".colorize(:color => :black)
  #   end
  # end

end

class Null_Piece < Piece
  include Singleton

  def initialize
  end

  def symbol
    " ⃞ "
  end
end


module SlidingPiece
  def moves
    moves = []
    move_dirs.each do |direction|
      moves << grow_unblocked_moves_in_dir(direction)
    end
    moves
  end

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  private

  HORIZONTAL_DIRS = [[0, -1], [0, 1], [1, 0], [-1, 0]]
  DIAGONAL_DIRS = [[-1, 1], [-1, -1], [1, -1], [1, 1]]

  def move_dirs
    raise NotImplementedError
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    possible_moves = []
    x, y = @piece.pos
    while @board[[x, y]].empty? && @board.valid_pos([x, y])
      x += dx
      y += dy
      possible_moves << [x,y]
    end
    possible_moves
  end
end


class Bishop < Piece
  include SlidingPiece

  def symbol
    if @color == "white"
      " ♗ "
    else
      " ♝ "
    end
  end

  def move_dirs
    diagonal_dirs
  end

end

class Rook < Piece
  include SlidingPiece

  def symbol
    if @color == 'white'
      " ♖ "
    else
      " ♜ "
    end
  end

  def move_dirs
    horizontal_dirs
  end

end


class Queen < Piece
  include SlidingPiece
  #debugger

  def symbol
    if @color == 'white'
      " ♕ "
    else
      " ♛ "
    end
  end

  def move_dirs
    horizontal_dirs
    diagonal_dirs
  end

end

module SteppingPiece
  def moves

  end

  private
  def move_diffs

  end
end

class Knight < Piece
  include SteppingPiece

  def symbol
    if @color == 'white'
      " ♘ "
    else
      " ♞ "
    end
  end

  def move_diffs

  end

end

class King < Piece
  include SteppingPiece

  def symbol
    if @color == 'white'
      " ♔ "
    else
      " ♚ "
    end
  end

  def move_diifs

  end

end

class Pawn < Piece
  def symbol
    if @color == 'white'
      " ♙ "
    else
      " ♟ "
    end
  end
end
