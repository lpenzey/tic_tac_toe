defmodule Game do
  def init do
    %State{}
  end

  def over(state) do
    Output.display_board(state)
    Output.end_of_game(state)
  end

  def play(state) do
    new_state =
      Input.retrieve()
      |> Input.analyze(state)
      |> Output.display_board()
      |> ComputerPlayer.make_move()
      |> Output.display_message(:opponent_move)
      |> Output.display_board()

    cond do
      Status.over(State.get_board(new_state)) == :game_in_progress ->
        play(new_state)

      Status.over(State.get_board(new_state)) == :game_over ->
        over(new_state)
    end
  end
end
