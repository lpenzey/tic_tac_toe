defmodule TicTacToe do
  def main(_args) do
    Output.welcome()
    state = Game.init()
    Output.display_board(state)
    Game.play(false, state)
  end
end
