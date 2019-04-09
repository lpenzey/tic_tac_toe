defmodule Input do
  def retrieve do
    IO.stream(:stdio, :line)
  end

  def user_move_to_internal_state(move) do
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
      :error
    )
  end

  def number?(move) do
    try do
      String.to_integer(move)
      true
    rescue
      ArgumentError -> false
    end
  end

  def valid?(move) do
    case user_move_to_internal_state(move) do
      {_, _} ->
        true

      :error ->
        false
    end
  end

  def open?(move, state) do
    spot = Map.get(state.board, user_move_to_internal_state(move), :error)

    cond do
      spot == state.player -> false
      spot == String.to_integer(move) -> true
      spot == :error -> Output.get_message(:space_taken)
    end
  end

  def process_move(move, state) do
    cond do
      !number?(move) ->
        Output.get_message(:nan)
        |> IO.puts()

        state

      !valid?(move) ->
        Output.get_message(:nonexistant_space)
        |> IO.puts()

        state

      !open?(move, state) ->
        Output.get_message(:space_taken)
        |> IO.puts()

        state

      true ->
        user_move_to_internal_state(move)
        |> State.set_move(state)
    end
  end
end
