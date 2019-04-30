defmodule Game do
  def init(token \\ "X") do
    %State{player: token}
  end

  def over(state) do
    Messages.display_board(state)
    Messages.end_of_game(state)
  end

  def play(state, deps) do
    deps.messages.display_board(state)

    new_state =
      human_move(state, deps)
      |> deps.messages.display_board()
      |> computer_move()
      |> deps.messages.display_message(:opponent_move)

    cond do
      Status.over(State.get_board(new_state)) == :game_in_progress ->
        play(new_state, deps)

      Status.over(State.get_board(new_state)) == :game_over ->
        over(new_state)
    end
  end

  def human_move(state, deps) do
    deps.io.retrieve(:choose)
    |> deps.validation.sanitized_move()
    |> HumanPlayer.analyze(state, deps)
  end

  def computer_move(state) do
    ComputerPlayer.make_move(state)
  end
end
