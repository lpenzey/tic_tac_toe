defmodule Game do
  @mode1 :human_v_human
  @mode2 :human_v_easy_computer
  @mode3 :human_v_hard_computer

  def start(io) do
    io.display(Messages.get_message(:welcome))
    state = get_options(io)
    play(state, io, state.mode)
  end

  def get_options(io) do
    mode = select_mode(Validation.choose_mode(io))
    player_token = Validation.choose_token(io)
    opponent_token = Validation.choose_token(io, player_token)
    current_player = Validation.choose_first_player(io, player_token, opponent_token)
    set_options(player_token, opponent_token, current_player, mode)
  end

  def set_options(player, opponent, current_player, mode) do
    %State{player: player, opponent: opponent, current_player: current_player, mode: mode}
  end

  def select_mode(mode) when mode == "1", do: @mode1
  def select_mode(mode) when mode == "2", do: @mode2
  def select_mode(mode) when mode == "3", do: @mode3

  def play(state, io, mode) do
    Messages.display_board(io, state)
    player1 = state.player
    player2 = state.opponent

    case state.current_player do
      ^player1 ->
        human_move(state, io, mode)
        |> check_status(io, mode)

      ^player2 ->
        opponent(state, io, mode)
        |> check_status(io, mode)
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

  def over(io, state) do
    Messages.display_board(io, state)
    Messages.end_of_game(io, state)
  end

  def human_move(state, io, _mode) do
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

  defp opponent(state, io, @mode1) do
    human_move(state, io, @mode1)
  end

  defp opponent(state, _io, @mode2) do
    easy_computer_move(state)
  end

  defp opponent(state, _io, @mode3) do
    hard_computer_move(state)
  end
end
