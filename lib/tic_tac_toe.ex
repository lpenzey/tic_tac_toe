defmodule TicTacToe do
  def main(client) do
    Output.welcome(client)
    state = Game.init()
    Output.print_board(state, client)

    Input.retrieve()
    |> Enum.reduce(state, &Game.play/2)
  end
end
