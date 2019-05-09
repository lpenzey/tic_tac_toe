defmodule Game do
  @mode1 :human_v_human
  @mode2 :human_v_easy_computer
  @mode3 :human_v_hard_computer
  def set_options(player, opponent, mode) do
    %State{player: player, opponent: opponent, current_player: player, mode: mode}
  end

  def start(deps) do
    deps.io.display(Messages.get_message(:welcome))
    mode = select_mode(Validation.choose_mode(deps))
    player_token = Player.choose_token(deps)
    opponent_symbol = Player.choose_token(deps, player_token)
    state = set_options(player_token, opponent_symbol, mode)
    play(state, deps, mode)
  end

  def select_mode(mode) when mode == "1", do: @mode1
  def select_mode(mode) when mode == "2", do: @mode2
  def select_mode(mode) when mode == "3", do: @mode3

  def over(io, state) do
    Messages.display_board(io, state)
    Messages.end_of_game(io, state)
  end

  def play(state, deps, mode) do
    case mode do
      @mode1 ->
        Messages.display_board(deps.io, state)

        human_move(state, deps)
        |> check_status(deps, :human_v_human)

      @mode2 ->
        Messages.display_board(deps.io, state)

        human_move(state, deps)
        |> easy_computer_move()
        |> check_status(deps, :human_v_easy_computer)

      @mode3 ->
        Messages.display_board(deps.io, state)

        human_move(state, deps)
        |> hard_computer_move()
        |> check_status(deps, :human_v_hard_computer)
    end
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
    deps.io.retrieve(state.current_player <> Messages.get_message(:choose))
    |> Validation.sanitized_move()
    |> Player.analyze(state, deps)
  end

  def hard_computer_move(state) do
    move =
      try do
        Minimax.minimax(state).position
      rescue
        e in KeyError -> {:error, e}
      end

    case move do
      {:error, _} ->
        state

      _ ->
        Player.place_move(move, state)
    end
  end

  def easy_computer_move(state) do
    move = Player.select_move(state)

    case move do
      {:error, "empty error"} ->
        state

      _ ->
        Player.place_move(move, state)
    end
  end
end
