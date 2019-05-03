defmodule Game do
  @input_output Application.get_env(:tic_tac_toe, :console_io)

  def init(player_token \\ "X") do
    %State{player: player_token}
  end

  def select_mode(mode) when mode == "1", do: :human_v_human
  def select_mode(mode) when mode == "2", do: :human_v_computer

  def over(state) do
    over(@input_output, state)
  end

  def over(io, state) do
    Messages.display_board(io, state, :console)
    Messages.end_of_game(io, state)
  end

  def play(state, deps, mode) when mode == :human_v_human do
    deps.messages.display_board(state)

    human_move(state, deps)
    |> check_status(deps, :human_v_human)
  end

  def play(state, deps, mode) when mode == :human_v_computer do
    deps.messages.display_board(state)

    human_move(state, deps)
    |> computer_move()
    |> check_status(deps, :human_v_computer)
  end

  def check_status(state, deps, mode) do
    cond do
      Status.over(State.get_board(state)) == :game_in_progress ->
        play(state, deps, mode)

      Status.over(State.get_board(state)) == :game_over ->
        over(state)
    end
  end

  def human_move(state, deps) do
    deps.io.retrieve(deps.messages.get_message(:choose))
    |> deps.validation.sanitized_move()
    |> deps.player.analyze(state, deps)
  end

  def computer_move(state) do
    move = Player.select_move(state)

    case move do
      {:error, "empty error"} ->
        state

      _ ->
        Player.place_move(move, state)
    end
  end
end
