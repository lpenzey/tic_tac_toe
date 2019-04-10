defmodule Validity do
  def user_move_to_internal_state(move) do
    try do
      Map.get(
        %{
          1 => {0, 0},
          2 => {0, 1},
          3 => {0, 2},
          4 => {1, 0},
          5 => {1, 1},
          6 => {1, 2},
          7 => {2, 0},
          8 => {2, 1},
          9 => {2, 2}
        },
        String.to_integer(move),
        :nonexistant_space
      )
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

  def number?(move) do
    try do
      String.to_integer(move)
      true
    rescue
      ArgumentError -> false
    end
  end

  def open?(move, state) do
    spot = Map.get(State.get_board(state), user_move_to_internal_state(move), :space_taken)

    cond do
      is_binary(spot) -> false
      spot == String.to_integer(move) -> true
      spot == :space_taken -> Output.get_message(:space_taken)
    end
  end
end
