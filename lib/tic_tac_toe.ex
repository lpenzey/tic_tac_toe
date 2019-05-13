defmodule TicTacToe do
  def main(_opts \\ []) do
    io = OptionsBuilder.init()
    Game.start(io)
  end
end
