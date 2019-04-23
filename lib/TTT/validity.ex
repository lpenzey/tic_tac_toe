defmodule Validity do
  def space_on_board?(move) do
    cond do
      State.user_move_to_internal_state(move) == {:error, :nonexistant_space} ->
        {:error, :nonexistant_space}

      true ->
        {:ok, :space_on_board}
    end
  end

  def open?(move, state) do
    spot = Map.get(State.get_board(state), State.user_move_to_internal_state(move))

    cond do
      is_binary(spot) -> {:error, :space_taken}
      spot == move -> {:ok, :is_open}
      spot == nil -> {:error, :space_taken}
    end
  end
end
