require 'colorize'
require_relative "board"
require_relative "cursor"
require "byebug"
require_relative "piece"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def play
    while true
      move = get_move
      @board.move_piece(move[0], move[1])
      render
    end
  end
  
  def get_move
    render
    start_pos = nil
    until start_pos  
      start_pos = @cursor.get_input
      render
    end
    #puts start_pos
    end_pos = nil
    until end_pos
      end_pos = @cursor.get_input
      render    
    end
    [start_pos, end_pos]
  end

  def render
    system('clear')
    @board.board.each_with_index do |row, idx1|
      row.each_with_index do |col, idx2|
         # debugger
        if [idx1, idx2] == @cursor.cursor_pos
          print @board[@cursor.cursor_pos].symbol.to_s.colorize(:background => :yellow)
        elsif (idx1 + idx2).even?
          print col.symbol.colorize(:background => :magenta)
        else
          print col.symbol
        end
      end
      print "\n"
    end
    prints
  end
  def prints
    puts '_________________________'
    puts "  "
  end
end

d = Display.new(Board.new)
d.play
