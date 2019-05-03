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
      deps.io.retrieve(deps.messages.get_message(:choose_token))
      |> deps.validation.clean()
      |> String.upcase()

    case token do
      "X" ->
        token

      "O" ->
        token

      _ ->
        choose_token(deps)
    end
  end

  def analyze(move, state, deps) do
    with {:ok, :space_on_board} <- deps.validation.space_on_board?(move),
         {:ok, :is_open} <- deps.validation.open?(move, state) do
      place_move(move, state)
    else
      {:error, :nonexistant_space} ->
        deps.messages.display_message(state, :nonexistant_space)
        deps.io.retrieve(:choose) |> deps.validation.sanitized_move() |> analyze(state, deps)

      {:error, :space_taken} ->
        deps.messages.display_message(state, :space_taken)
        deps.io.retrieve(:choose) |> deps.validation.sanitized_move() |> analyze(state, deps)
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