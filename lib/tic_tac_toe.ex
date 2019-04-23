defmodule TicTacToe do
  def main(_args) do
    Output.welcome()
    state = Game.init(Input.choose_token())
    Output.display_board(state)
    Game.play(state)
  end
end
