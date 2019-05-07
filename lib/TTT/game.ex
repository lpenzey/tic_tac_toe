defmodule Game do
  def set_tokens(player, opponent) do
    %State{player: player, opponent: opponent, current_player: player}
  end

  def start(deps) do
    deps.io.display(Messages.get_message(:welcome))
    mode = select_mode(Validation.choose_mode(deps))
    player_token = Player.choose_token(deps)
    opponent_symbol = Player.choose_token(deps, player_token)
    state = set_tokens(player_token, opponent_symbol)
    play(state, deps, mode)
  end

  def select_mode(mode) when mode == "1", do: :human_v_human
  def select_mode(mode) when mode == "2", do: :human_v_computer

  def over(io, state) do
    Messages.display_board(io, state)
    Messages.end_of_game(io, state)
  end

  def play(state, deps, mode) when mode == :human_v_human do
    Messages.display_board(deps.io, state)

    human_move(state, deps)
    |> check_status(deps, :human_v_human)
  end

  def play(state, deps, mode) when mode == :human_v_computer do
    Messages.display_board(deps.io, state)

    human_move(state, deps)
    |> computer_move()
    |> check_status(deps, :human_v_computer)
  end

  def check_status(state, deps, mode) do
    cond do
      Status.over(State.get_board(state)) == :game_in_progress ->
        play(state, deps, mode)

      Status.over(State.get_board(state)) == :game_over ->
        over(deps.io, state)
    end
  end

  def human_move(state, deps) do
    deps.io.retrieve(Messages.get_message(:choose))
    |> Validation.sanitized_move()
    |> Player.analyze(state, deps)
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
