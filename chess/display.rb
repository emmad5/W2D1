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
    render
    @cursor.get_input
    render
    @cursor.get_input

    render
  end

  def render
    #debugger
    @board.board.each_with_index do |row, idx1|
      row.each_with_index do |col, idx2|
         # debugger
        if [idx1, idx2] == @cursor.cursor_pos
          print @board[@cursor.cursor_pos].symbol.to_s.colorize(:background => :yellow)
        else
          print col.symbol
        end
      end
      print "\n"
    end
    puts '_________________________'
    puts "  "
  end
end

d = Display.new(Board.new)
d.play
