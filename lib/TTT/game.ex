defmodule Game do
  def init(token \\ "X") do
    %State{player: token}
  end

  def over(state) do
    Output.display_board(state)
    Output.end_of_game(state)
  end

  def play(state) do
    new_state =
      human_move(state)
      |> Output.display_board()
      |> computer_move()
      |> Output.display_message(:opponent_move)
      |> Output.display_board()

    cond do
      Status.over(State.get_board(new_state)) == :game_in_progress ->
        play(new_state)

      Status.over(State.get_board(new_state)) == :game_over ->
        over(new_state)
    end
  end

  def human_move(state) do
    Input.retrieve(:choose)
    |> Input.sanitized_move()
    |> Input.analyze(state)
  end

  def computer_move(state) do
    ComputerPlayer.make_move(state)
  end
end
