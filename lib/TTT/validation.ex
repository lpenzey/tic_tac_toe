defmodule Validation do
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

  def choose_mode(io) do
    mode =
      io.retrieve(Messages.get_message(:choose_mode))
      |> Validation.clean()

    case mode do
      "1" ->
        mode

      "2" ->
        mode

      "3" ->
        mode

      _ ->
        choose_mode(io)
    end
  end

  def choose_token(io) do
    io.retrieve(Messages.get_message(:choose_token))
    |> clean()
    |> validate_token(io)
  end

  def choose_token(io, player_token) do
    io.retrieve(Messages.get_message(:choose_opponent_token))
    |> clean()
    |> validate_token(player_token, io)
  end

  def validate_token(token, io) when byte_size(token) != 1 do
    io.display(Messages.get_message(:token_length_error))
    choose_token(io)
  end

  def validate_token(token, _io) when byte_size(token) == 1 do
    token
  end

  def validate_token(opponent_token, player_token, io) when opponent_token == player_token do
    io.display(Messages.get_message(:same_token))
    choose_token(io, player_token)
  end

  def validate_token(opponent_token, player_token, io)
      when byte_size(opponent_token) != 1 do
    io.display(Messages.get_message(:token_length_error))
    choose_token(io, player_token)
  end

  def validate_token(opponent_token, player_token, _io)
      when opponent_token != player_token and byte_size(opponent_token) == 1 do
    opponent_token
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

  def clean(input) do
    String.trim(input)
  end

  defp to_int(input) do
    try do
      String.to_integer(input)
    rescue
      ArgumentError -> {:error, :not_a_number}
    end
  end
end
