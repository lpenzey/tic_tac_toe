defmodule Game do
  @mode1 :human_v_human
  @mode2 :human_v_easy_computer
  @mode3 :human_v_hard_computer
  def set_options(player, opponent, mode) do
    %State{player: player, opponent: opponent, current_player: player, mode: mode}
  end

  def start(io) do
    io.display(Messages.get_message(:welcome))
    mode = select_mode(Validation.choose_mode(io))
    player_token = Validation.choose_token(io)
    opponent_symbol = Validation.choose_token(io, player_token)
    state = set_options(player_token, opponent_symbol, mode)
    play(state, io, mode)
  end

  def select_mode(mode) when mode == "1", do: @mode1
  def select_mode(mode) when mode == "2", do: @mode2
  def select_mode(mode) when mode == "3", do: @mode3

  def over(io, state) do
    Messages.display_board(io, state)
    Messages.end_of_game(io, state)
  end

  def play(state, io, mode) do
    case mode do
      @mode1 ->
        Messages.display_board(io, state)

        human_move(state, io)
        |> check_status(io, :human_v_human)

      @mode2 ->
        Messages.display_board(io, state)

        human_move(state, io)
        |> easy_computer_move()
        |> check_status(io, :human_v_easy_computer)

      @mode3 ->
        Messages.display_board(io, state)

        human_move(state, io)
        |> hard_computer_move()
        |> check_status(io, :human_v_hard_computer)
    end
  end

  def check_status(state, io, mode) do
    cond do
      Status.over(State.get_board(state)) == :game_in_progress ->
        play(state, io, mode)

      Status.over(State.get_board(state)) == :game_over ->
        over(io, state)
    end
  end

  def human_move(state, io) do
    io.retrieve(state.current_player <> Messages.get_message(:choose))
    |> Validation.sanitized_move()
    |> Player.check_move(state, io)
  end

  def hard_computer_move(state) do
    try do
      Minimax.minimax(state).position
      |> Player.place_move(state)
    rescue
      e in KeyError ->
        {:error, e}
        state
    end
  end

  def easy_computer_move(state) do
    try do
      Player.select_move(state)
      |> Player.place_move(state)
    rescue
      e in KeyError ->
        {:error, e}
        state
    end
  end
end
