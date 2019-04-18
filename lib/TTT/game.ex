defmodule Game do
  def init do
    %State{}
  end

  def play(true, state) do
    Output.display_board(state)
    Output.end_of_game(state)
  end

  def play(false, state) do
    new_state =
      Input.retrieve()
      |> Input.analyze(state)
      |> Output.display_board()
      |> ComputerPlayer.make_move()
      |> Output.display_message(:opponent_move)
      |> Output.display_board()

    play(Status.over?(State.get_board(new_state)), new_state)
  end
end
