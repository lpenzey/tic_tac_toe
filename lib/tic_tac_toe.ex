defmodule TicTacToe do
  def main(_opts \\ []) do
    deps = OptionsBuilder.init()
    Game.start(deps)
  end
end
