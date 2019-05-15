defmodule TicTacToe do
  def main(_opts \\ []) do
    OptionsBuilder.init()
    |> Game.start()
  end
end
