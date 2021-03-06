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

  def check_move(move, state, io) do
    with {:ok, :space_on_board} <- Validation.space_on_board?(move),
         {:ok, :is_open} <- Validation.open?(move, state) do
      place_move(move, state)
    else
      {:error, :nonexistant_space} ->
        Messages.display_message(io, :nonexistant_space)
        get_input(state, io)

      {:error, :space_taken} ->
        Messages.display_message(io, :space_taken)
        get_input(state, io)
    end
  end

  def place_move(move, state) when is_integer(move) do
    Validation.user_move_to_internal_state(move)
    |> State.set_move(state)
  end

  def place_move(move, state) when is_tuple(move) do
    State.set_move(move, state)
  end

  defp get_input(state, io) do
    io.retrieve(Messages.get_message(:choose))
    |> Validation.sanitized_move()
    |> check_move(state, io)
  end
end
