defmodule Validation do
  def clean(input) do
    String.trim(input)
  end

  def to_int(input) do
    try do
      String.to_integer(input)
    rescue
      ArgumentError -> {:error, :not_a_number}
    end
  end

  def sanitized_move(input) do
    clean(input)
    |> to_int()
  end

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
        move,
        {:error, :nonexistant_space}
      )
    rescue
      ArgumentError -> {:error, :nonexistant_space}
    end
  end

  def choose_mode(deps) do
    mode =
      deps.io.retrieve(deps.messages.get_message(:choose_mode))
      |> deps.validation.clean()

    case mode do
      "1" ->
        mode

      "2" ->
        mode

      _ ->
        choose_mode(deps)
    end
  end

  def space_on_board?(move) do
    cond do
      user_move_to_internal_state(move) == {:error, :nonexistant_space} ->
        {:error, :nonexistant_space}

      true ->
        {:ok, :space_on_board}
    end
  end

  def open?(move, state) do
    spot = Map.get(State.get_board(state), user_move_to_internal_state(move))

    cond do
      is_binary(spot) -> {:error, :space_taken}
      spot == move -> {:ok, :is_open}
      spot == nil -> {:error, :space_taken}
    end
  end
end
