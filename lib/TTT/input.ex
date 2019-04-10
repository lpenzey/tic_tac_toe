defmodule Input do
  def retrieve do
    IO.stream(:stdio, :line)
  end

  def clean(input) do
    String.trim(input)
  end

  def analyze(move, state) do
    with {:ok, :is_number} <- Validity.number?(move),
         {:ok, :space_on_board} <- Validity.space_on_board?(move),
         {:ok, :is_open} <- Validity.open?(move, state),
         do: place_move(move, state)
  end

  def place_move(move, state) do
    Validity.user_move_to_internal_state(move)
    |> State.set_move(state)
  end
end
