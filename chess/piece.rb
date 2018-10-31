require "colorize"
require "singleton"
require "byebug"

class Piece
  attr_reader :board

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves

  end

end

class Null_Piece < Piece
  include Singleton

  def initialize
  end

  def symbol
    "   "
  end
end


module SlidingPiece
  def moves
    #debugger
    moves = []
    move_dirs.each do |direction|
      moves << grow_unblocked_moves_in_dir(direction[0], direction[1])
      p moves
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
    #debugger
    x, y = @pos[0], @pos[1]
    while @board[[x, y]].is_a? Null_Piece
      x += dx
      y += dy
      possible_moves << [x,y]
      p possible_moves
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
    raise NotImplementedError
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
    [[1, 2], [2, 1], [-1, 2], [-2, 1], [-1, -2], [1, -2], [2, -1], [-2, -1]]
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
    [[0, 1], [1, 0], [0, -1], [-1, 0]]
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
