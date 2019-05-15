defmodule Game do
  @mode1 :human_v_human
  @mode2 :human_v_easy_computer
  @mode3 :human_v_hard_computer

  def start(io) do
    io.display(Messages.get_message(:welcome))
    mode = select_mode(Validation.choose_mode(io))
    player_token = Validation.choose_token(io)
    opponent_symbol = Validation.choose_token(io, player_token)
    state = set_options(player_token, opponent_symbol, mode)
    play(state, io, mode)
  end

  def set_options(player, opponent, mode) do
    %State{player: player, opponent: opponent, current_player: player, mode: mode}
  end

  def select_mode(mode) when mode == "1", do: @mode1
  def select_mode(mode) when mode == "2", do: @mode2
  def select_mode(mode) when mode == "3", do: @mode3

  def over(io, state) do
    Messages.display_board(io, state)
    Messages.end_of_game(io, state)
  end

  def play(state, io, mode) do
    Messages.display_board(io, state)

    human_move(state, io)
    |> opponent(io, mode)
    |> check_status(io, mode)
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

  defp opponent(state, io, mode) when mode == @mode1 do
    human_move(state, io)
  end

  defp opponent(state, _io, mode) when mode == @mode2 do
    easy_computer_move(state)
  end

  defp opponent(state, _io, mode) when mode == @mode3 do
    hard_computer_move(state)
  end
end
