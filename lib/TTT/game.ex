defmodule Game do
  def init(token \\ "X") do
    %State{player: token}
  end

  def over(state) do
    Output.display_board(state)
    Output.end_of_game(state)
  end

  def play(state, deps) do
    deps.output.display_board(state)

    new_state =
      human_move(state, deps)
      |> deps.output.display_board()
      |> computer_move()
      |> deps.output.display_message(:opponent_move)

    cond do
      Status.over(State.get_board(new_state)) == :game_in_progress ->
        play(new_state, deps)

      Status.over(State.get_board(new_state)) == :game_over ->
        over(new_state)
    end
  end

  def human_move(state, deps) do
    deps.input.retrieve(:choose)
    |> deps.input.sanitized_move()
    |> HumanPlayer.analyze(state, deps)
  end

  def computer_move(state) do
    ComputerPlayer.make_move(state)
  end
end
