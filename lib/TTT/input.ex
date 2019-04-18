defmodule Input do
  def retrieve do
    IO.gets(Output.get_message(:choose))
    |> sanitized_move()
  end

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

  def analyze(move, state) do
    with {:ok, :space_on_board} <- Validity.space_on_board?(move),
         {:ok, :is_open} <- Validity.open?(move, state) do
      place_move(move, state)
    else
      _ -> retrieve() |> analyze(state)
    end
  end

  def place_move(move, state) do
    Board.user_move_to_internal_state(move)
    |> State.set_move(state)
  end
end
