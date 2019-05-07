defmodule Player do
  def available_moves(state) do
    board = State.get_board(state)
    for {key, value} <- board, is_number(value), into: %{}, do: {key, value}
  end

  def select_move(state) do
    try do
      available_moves(state)
      |> Map.keys()
      |> Enum.random()
    rescue
      e in Enum.EmptyError -> {:error, e.message}
    end
  end

  def choose_token(deps) do
    token =
      deps.io.retrieve(Messages.get_message(:choose_token))
      |> Validation.clean()

    token
  end

  def choose_token(deps, player_token) do
    token =
      deps.io.retrieve(Messages.get_message(:choose_opponent_token))
      |> Validation.clean()

    if token == player_token do
      deps.io.display(Messages.get_message(:same_token))
      choose_token(deps, player_token)
    else
      token
    end
  end

  def analyze(move, state, deps) do
    with {:ok, :space_on_board} <- Validation.space_on_board?(move),
         {:ok, :is_open} <- Validation.open?(move, state) do
      place_move(move, state)
    else
      {:error, :nonexistant_space} ->
        Messages.display_message(deps.io, :nonexistant_space)
        deps.io.retrieve(:choose) |> Validation.sanitized_move() |> analyze(state, deps)

      {:error, :space_taken} ->
        Messages.display_message(deps.io, :space_taken)
        deps.io.retrieve(:choose) |> Validation.sanitized_move() |> analyze(state, deps)
    end
  end

  def place_move(move, state) when is_integer(move) do
    Validation.user_move_to_internal_state(move)
    |> State.set_move(state)
  end

  def place_move(move, state) when is_tuple(move) do
    State.set_move(move, state)
  end
end
