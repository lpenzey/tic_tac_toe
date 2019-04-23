defmodule ComputerPlayer do
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

  def make_move(state) do
    cond do
      select_move(state) !== {:error, "empty error"} ->
        select_move(state)
        |> State.set_move(state)

      select_move(state) == {:error, "empty error"} ->
        state
    end
  end
end
