defmodule Input do
  def retrieve(input_output \\ Application.get_env(:tic_tac_toe, :console_io), message) do
    input_output.gets(Output.get_message(message))
  end

  def choose_token do
    token = retrieve(:choose_token) |> clean() |> String.upcase()

    case token do
      "X" ->
        token

      "O" ->
        token

      _ ->
        choose_token()
    end
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
      {:error, :nonexistant_space} ->
        Output.display_message(state, :nonexistant_space)
        retrieve(:choose) |> sanitized_move() |> analyze(state)

      {:error, :space_taken} ->
        Output.display_message(state, :space_taken)
        retrieve(:choose) |> sanitized_move() |> analyze(state)
    end
  end

  def place_move(move, state) do
    State.user_move_to_internal_state(move)
    |> State.set_move(state)
  end
end
